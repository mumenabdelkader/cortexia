import json
import os
import re

def to_snake_case(name):
    s1 = re.sub('(.)([A-Z][a-z]+)', r'\1_\2', name)
    return re.sub('([a-z0-9])([A-Z])', r'\1_\2', s1).lower().replace('-', '_').replace('__', '_')

def to_pascal_case(name):
    return ''.join(word.capitalize() for word in re.split(r'[^a-zA-Z0-9]', name) if word)

def to_camel_case(name):
    p = to_pascal_case(name)
    if not p: return ''
    return p[0].lower() + p[1:]

with open('swagger.json', 'r', encoding='utf-8') as f:
    swagger = json.load(f)

schemas = swagger.get('components', {}).get('schemas', {})
paths = swagger.get('paths', {})

enums = {}
models = {}
for name, s in schemas.items():
    if 'enum' in s: enums[name] = s
    else: models[name] = s

features = {}

for path, methods in paths.items():
    for method, details in methods.items():
        if method not in ['get', 'post', 'put', 'delete', 'patch']: continue
        tags = details.get('tags', ['core'])
        tag = tags[0]
        f_name = to_snake_case(tag)
        if f_name not in features: features[f_name] = {'endpoints':[], 'schemas':set()}
        features[f_name]['endpoints'].append({'path': path, 'method': method, 'details': details})

schema_to_feature = {}
def add_schema(sch, f):
    if sch not in schema_to_feature:
        schema_to_feature[sch] = f
        features[f]['schemas'].add(sch)

def find_refs(obj, f):
    if isinstance(obj, dict):
        if '$ref' in obj:
            ref = obj['$ref'].split('/')[-1]
            add_schema(ref, f)
            if ref in schemas: find_refs(schemas[ref], f)
        for k,v in obj.items(): find_refs(v, f)
    elif isinstance(obj, list):
        for i in obj: find_refs(i, f)

for f_name, data in features.items():
    for ep in data['endpoints']: find_refs(ep['details'], f_name)

for m in schemas:
    if m not in schema_to_feature:
        if 'core' not in features: features['core'] = {'endpoints': [], 'schemas': set()}
        add_schema(m, 'core')

def map_type(prop, use_model=True):
    if '$ref' in prop:
        ref_name = prop['$ref'].split('/')[-1]
        if ref_name in enums: return ref_name
        return f"{ref_name}Model" 
    t = prop.get('type', 'dynamic')
    if t == 'integer': return 'int'
    if t == 'number': return 'double'
    if t == 'boolean': return 'bool'
    if t == 'string': return 'String'
    if t == 'array':
        it = map_type(prop.get('items', {}), use_model)
        return f"List<{it}>"
    return 'dynamic'

for f_name, db in features.items():
    if f_name == 'authentication' or f_name == 'patient': continue
    feat_dir = f"lib/features/{f_name}"
    if not db['endpoints'] and not db['schemas']: list()
    
    os.makedirs(f"{feat_dir}/data/models", exist_ok=True)
    os.makedirs(f"{feat_dir}/data/apis", exist_ok=True)
    os.makedirs(f"{feat_dir}/data/repo", exist_ok=True)
    os.makedirs(f"{feat_dir}/domain/repo", exist_ok=True)
    os.makedirs(f"{feat_dir}/presentation/controllers", exist_ok=True)
    
    # GENERATE SCHEMAS
    for s_name in db.get('schemas', []):
        snk_name = to_snake_case(s_name)
        if s_name in enums:
            c = "import 'package:json_annotation/json_annotation.dart';\n\n"
            c += f"enum {s_name} {{\n"
            for val in enums[s_name]['enum']: c += f"  @JsonValue({val}) value{val},\n"
            c += "}\n"
            with open(f"{feat_dir}/data/models/{snk_name}.dart", 'w') as fh: fh.write(c)
            continue
        
        props = models[s_name].get('properties', {})
        imports = set()
        imports.add("import 'package:json_annotation/json_annotation.dart';")
        
        def add_ref_imports(p_details):
            if '$ref' in p_details:
                ref = p_details['$ref'].split('/')[-1]
                f_ref = schema_to_feature.get(ref, 'core')
                if f_ref != f_name or ref != s_name:
                    if ref in enums: imports.add(f"import 'package:cortexia/features/{f_ref}/data/models/{to_snake_case(ref)}.dart';")
                    else: imports.add(f"import 'package:cortexia/features/{f_ref}/data/models/{to_snake_case(ref)}_model.dart';")
            elif p_details.get('type') == 'array' and '$ref' in p_details.get('items', {}):
                add_ref_imports(p_details['items'])
                
        for p_details in props.values():
            add_ref_imports(p_details)
            
        mod = "\n".join(imports) + "\n\n"
        mod += f"part '{snk_name}_model.g.dart';\n\n"
        mod += f"@JsonSerializable()\n"
        mod += f"class {s_name}Model {{\n"
        
        for p_name, p_details in props.items():
            t = map_type(p_details, use_model=True)
            mod += f"  {t}? {p_name};\n"
            
        if props:
            mod += f"\n  {s_name}Model({{"
            mod += ", ".join([f"this.{p}" for p in props.keys()])
            mod += "});\n\n"
        else:
            mod += f"\n  {s_name}Model();\n\n"
        
        mod += f"  factory {s_name}Model.fromJson(Map<String, dynamic> json) => _${s_name}ModelFromJson(json);\n\n"
        mod += f"  Map<String, dynamic> toJson() => _${s_name}ModelToJson(this);\n"
        mod += "}\n"
        
        with open(f"{feat_dir}/data/models/{snk_name}_model.dart", 'w') as fh: fh.write(mod)

    # API & REPO
    if not db['endpoints']: continue
    
    api_imports = set()
    api_imports.add("import 'package:dio/dio.dart' hide Headers;")
    api_imports.add("import 'package:retrofit/retrofit.dart';")
    api_imports.add("import 'package:cortexia/core/networking/api_constants.dart';")
    
    api_code = f"part '{f_name}_service.g.dart';\n\n"
    api_code += f"@RestApi(baseUrl: ApiConstants.baseUrl)\n"
    api_code += f"abstract class {to_pascal_case(f_name)}Service {{\n  factory {to_pascal_case(f_name)}Service(Dio dio, {{String baseUrl}}) = _{to_pascal_case(f_name)}Service;\n\n"
    
    repo_imports = set()
    repo_imports.add("import 'package:cortexia/core/networking/api_result.dart';")
    
    repo_code = f"abstract class {to_pascal_case(f_name)}RepoInterface {{\n"
    
    repo_impl_imports = set()
    repo_impl_imports.add("import 'package:cortexia/core/networking/api_error_handler.dart';")
    repo_impl_imports.add("import 'package:cortexia/core/networking/api_result.dart';")
    repo_impl_imports.add(f"import 'package:cortexia/features/{f_name}/domain/repo/repo_interface.dart';")
    repo_impl_imports.add(f"import '../apis/{f_name}_service.dart';")
    
    repo_impl_code = f"class {to_pascal_case(f_name)}RepoImp implements {to_pascal_case(f_name)}RepoInterface {{\n"
    repo_impl_code += f"  final {to_pascal_case(f_name)}Service _apiService;\n"
    repo_impl_code += f"  {to_pascal_case(f_name)}RepoImp(this._apiService);\n\n"
    
    for ep in db['endpoints']:
        path = ep['path']
        clean_path = path.replace('/api', '') 
        method = ep['method']
        details = ep['details']
        op_id = details.get('operationId', f"{method}_{clean_path.replace('/', '_').replace('{', '').replace('}', '')}")
        op_name = to_camel_case(op_id)
        
        params = details.get('parameters', [])
        req_body = details.get('requestBody', {})
        
        api_args = []
        repo_args = []
        call_args = []
        
        for p in params:
            p_name = to_camel_case(p['name'])
            p_type = map_type(p.get('schema', {}), use_model=True)
            if p['in'] == 'path':
                api_args.append(f"@Path('{p['name']}') {p_type} {p_name}")
            elif p['in'] == 'query':
                # Map complex queries to @Queries or primitive to @Query
                if '$ref' in p.get('schema', {}):
                    api_args.append(f"@Queries() {p_type} {p_name}")
                else:
                    api_args.append(f"@Query('{p['name']}') {p_type} {p_name}")
                    
            repo_args.append(f"{p_type} {p_name}")
            call_args.append(p_name)
            
            # Imports
            if '$ref' in p.get('schema', {}):
                ref = p['schema']['$ref'].split('/')[-1]
                f_ref = schema_to_feature.get(ref, 'core')
                if ref in enums:
                    api_imports.add(f"import 'package:cortexia/features/{f_ref}/data/models/{to_snake_case(ref)}.dart';")
                    repo_imports.add(f"import 'package:cortexia/features/{f_ref}/data/models/{to_snake_case(ref)}.dart';")
                    repo_impl_imports.add(f"import 'package:cortexia/features/{f_ref}/data/models/{to_snake_case(ref)}.dart';")
                else:
                    api_imports.add(f"import 'package:cortexia/features/{f_ref}/data/models/{to_snake_case(ref)}_model.dart';")
                    repo_imports.add(f"import 'package:cortexia/features/{f_ref}/data/models/{to_snake_case(ref)}_model.dart';")
                    repo_impl_imports.add(f"import 'package:cortexia/features/{f_ref}/data/models/{to_snake_case(ref)}_model.dart';")
            
        if req_body:
            schema = req_body.get('content', {}).get('application/json', {}).get('schema', {})
            if schema:
                body_type = map_type(schema, use_model=True)
                api_args.append(f"@Body() {body_type} requestBody")
                repo_args.append(f"{body_type} requestBody")
                call_args.append("requestBody")
                if '$ref' in schema:
                    ref = schema['$ref'].split('/')[-1]
                    f_ref = schema_to_feature.get(ref, 'core')
                    api_imports.add(f"import 'package:cortexia/features/{f_ref}/data/models/{to_snake_case(ref)}_model.dart';")
                    repo_imports.add(f"import 'package:cortexia/features/{f_ref}/data/models/{to_snake_case(ref)}_model.dart';")
                    repo_impl_imports.add(f"import 'package:cortexia/features/{f_ref}/data/models/{to_snake_case(ref)}_model.dart';")
                    
        return_type = 'dynamic'
        resp_schema = details.get('responses', {}).get('200', {}).get('content', {}).get('application/json', {}).get('schema', {})
        if resp_schema:
            return_type = map_type(resp_schema, use_model=True)
            if '$ref' not in resp_schema and resp_schema.get('type') == 'string': return_type = 'String'
            if return_type not in [m + 'Model' for m in models] and return_type not in enums and 'List<' not in return_type:
                return_type = 'dynamic'
            if '$ref' in resp_schema:
                ref = resp_schema['$ref'].split('/')[-1]
                f_ref = schema_to_feature.get(ref, 'core')
                if ref in enums:
                    api_imports.add(f"import 'package:cortexia/features/{f_ref}/data/models/{to_snake_case(ref)}.dart';")
                    repo_imports.add(f"import 'package:cortexia/features/{f_ref}/data/models/{to_snake_case(ref)}.dart';")
                    repo_impl_imports.add(f"import 'package:cortexia/features/{f_ref}/data/models/{to_snake_case(ref)}.dart';")
                else:
                    api_imports.add(f"import 'package:cortexia/features/{f_ref}/data/models/{to_snake_case(ref)}_model.dart';")
                    repo_imports.add(f"import 'package:cortexia/features/{f_ref}/data/models/{to_snake_case(ref)}_model.dart';")
                    repo_impl_imports.add(f"import 'package:cortexia/features/{f_ref}/data/models/{to_snake_case(ref)}_model.dart';")
        
        api_args_str = ", ".join(api_args)
        if api_args_str:
            fixed_api_args = []
            for arg in api_args:
                if arg.startswith('@'):
                    parts = arg.split(' ')
                    anno = parts[0]
                    rest = " ".join(parts[1:])
                    fixed_api_args.append(f"{anno} required {rest}")
                else:
                    fixed_api_args.append(f"required {arg}")
            api_args_str = f"{{{', '.join(fixed_api_args)}}}"
        
        repo_args_str = ", ".join(repo_args)
        if repo_args_str: repo_args_str = f"{{required {repo_args_str.replace(', ', ', required ')}}}"
        
        call_str = ", ".join([f"{a}: {a}" for a in call_args])
        
        api_code += f"  @{method.upper()}('{path}')\n"
        api_code += f"  Future<{return_type}> {op_name}({api_args_str});\n\n"
        
        repo_code += f"  Future<ApiResult<{return_type}>> {op_name}({repo_args_str});\n"
        
        repo_impl_code += f"  @override\n"
        repo_impl_code += f"  Future<ApiResult<{return_type}>> {op_name}({repo_args_str}) async {{\n"
        repo_impl_code += f"    try {{\n"
        repo_impl_code += f"      final response = await _apiService.{op_name}({call_str});\n"
        repo_impl_code += f"      return ApiResult.success(response);\n"
        repo_impl_code += f"    }} catch (error) {{\n"
        repo_impl_code += f"      return ApiResult.error(ApiErrorHandler.handle(error));\n"
        repo_impl_code += f"    }}\n"
        repo_impl_code += f"  }}\n\n"
        
    api_code += "}\n"
    repo_code += "}\n"
    repo_impl_code += "}\n"
    
    with open(f"{feat_dir}/data/apis/{f_name}_service.dart", 'w') as fh: fh.write("\n".join(api_imports) + "\n\n" + api_code)
    with open(f"{feat_dir}/domain/repo/repo_interface.dart", 'w') as fh: fh.write("\n".join(repo_imports) + "\n\n" + repo_code)
    with open(f"{feat_dir}/data/repo/{f_name}_repo_imp.dart", 'w') as fh: fh.write("\n".join(repo_impl_imports) + "\n\n" + repo_impl_code)

    # CUBIT & STATE
    cubit_name = f"{to_pascal_case(f_name)}Cubit"
    state_name = f"{to_pascal_case(f_name)}State"
    
    state_code = "part of '" + f_name + "_cubit.dart';\n\n"
    state_code += f"@immutable\n"
    state_code += f"abstract class {state_name} {{}}\n\n"
    state_code += f"class {state_name}Initial extends {state_name} {{}}\n"
    state_code += f"class {state_name}Loading extends {state_name} {{}}\n"
    state_code += f"class {state_name}Success extends {state_name} {{\n"
    state_code += f"  final dynamic data;\n  final String operation;\n"
    state_code += f"  {state_name}Success({{required this.operation, this.data}});\n"
    state_code += f"}}\n"
    state_code += f"class {state_name}Error extends {state_name} {{\n"
    state_code += f"  final String message;\n"
    state_code += f"  {state_name}Error({{required this.message}});\n"
    state_code += f"}}\n"
    
    with open(f"{feat_dir}/presentation/controllers/{f_name}_state.dart", 'w') as fh: fh.write(state_code)

    cb_code = f"import 'package:flutter_bloc/flutter_bloc.dart';\n"
    cb_code += f"import 'package:flutter/material.dart';\n"
    cb_code += f"import 'package:meta/meta.dart';\n"
    cb_code += f"import 'package:cortexia/features/{f_name}/domain/repo/repo_interface.dart';\n"
    
    for ep in db['endpoints']:
        req_body = ep['details'].get('requestBody', {})
        if req_body:
            schema = req_body.get('content', {}).get('application/json', {}).get('schema', {})
            if schema and '$ref' in schema:
                ref = schema['$ref'].split('/')[-1]
                f_ref = schema_to_feature.get(ref, 'core')
                cb_code += f"import 'package:cortexia/features/{f_ref}/data/models/{to_snake_case(ref)}_model.dart';\n"
        
        for p in ep['details'].get('parameters', []):
            if p['in'] == 'query' and '$ref' in p.get('schema', {}):
                ref = p['schema']['$ref'].split('/')[-1]
                f_ref = schema_to_feature.get(ref, 'core')
                cb_code += f"import 'package:cortexia/features/{f_ref}/data/models/{to_snake_case(ref)}_model.dart';\n"
                
    cb_code += f"\npart '{f_name}_state.dart';\n\n"
    cb_code += f"class {cubit_name} extends Cubit<{state_name}> {{\n"
    cb_code += f"  final {to_pascal_case(f_name)}RepoInterface _repo;\n\n"
    cb_code += f"  {cubit_name}(this._repo) : super({state_name}Initial());\n\n"
    
    for ep in db['endpoints']:
        path = ep['path']
        clean_path = path.replace('/api', '') 
        method = ep['method']
        details = ep['details']
        op_id = details.get('operationId', f"{method}_{clean_path.replace('/', '_').replace('{', '').replace('}', '')}")
        op_name = to_camel_case(op_id)
        
        args = []
        call_params = []
        for p in ep['details'].get('parameters', []):
            t = map_type(p.get('schema', {}), use_model=True)
            args.append(f"required {t} {to_camel_case(p['name'])}")
            call_params.append(f"{to_camel_case(p['name'])}: {to_camel_case(p['name'])}")
            
        req_body = ep['details'].get('requestBody', {})
        if req_body:
            schema = req_body.get('content', {}).get('application/json', {}).get('schema', {})
            if schema: 
                body_type = map_type(schema, use_model=True)
                args.append(f"required {body_type} requestBody")
                call_params.append("requestBody: requestBody")
            
        args_str = ", ".join(args)
        if args_str: args_str = f"{{{args_str}}}"
        call_str = ", ".join(call_params)
        
        cb_code += f"  Future<void> {op_name}({args_str}) async {{\n"
        cb_code += f"    emit({state_name}Loading());\n"
        cb_code += f"    final response = await _repo.{op_name}({call_str});\n"
        
        cb_code += f"    response.when(\n"
        cb_code += f"      onSuccess: (data) {{\n"
        cb_code += f"        emit({state_name}Success(operation: '{op_name}', data: data));\n"
        cb_code += f"      }},\n"
        cb_code += f"      onError: (error) {{\n"
        cb_code += f"        emit({state_name}Error(message: error.messages.first));\n"
        cb_code += f"      }},\n"
        cb_code += f"    );\n"
        cb_code += f"  }}\n\n"
        
    cb_code += "}\n"
    with open(f"{feat_dir}/presentation/controllers/{f_name}_cubit.dart", 'w') as fh: fh.write(cb_code)

print("Retrofit Swagger API generator finished.")
