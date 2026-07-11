import 'package:json_annotation/json_annotation.dart';

part 'get_all_patients_query_model.g.dart';

@JsonSerializable()
class GetAllPatientsQueryModel {

  GetAllPatientsQueryModel();

  factory GetAllPatientsQueryModel.fromJson(Map<String, dynamic> json) => _$GetAllPatientsQueryModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllPatientsQueryModelToJson(this);
}
