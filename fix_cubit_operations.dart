import 'dart:io';

void main() async {
  final libDir = Directory('c:/Users/KIMO/StudioProjects/cortexia/lib/features');

  // Match: operation: 'postAdmissionsAdmissionidCaseHistory' -> operation: 'post'
  final postRegex = RegExp(r"operation:\s*'postAdmissionsAdmissionid([a-zA-Z]+)'");
  final getRegex = RegExp(r"operation:\s*'getAdmissionsAdmissionid([a-zA-Z]+)'");
  final putRegex = RegExp(r"operation:\s*'putAdmissionsAdmissionid([a-zA-Z]+)'");
  final deleteRegex = RegExp(r"operation:\s*'deleteAdmissionsAdmissionid([a-zA-Z]+)'");

  await for (var entity in libDir.list(recursive: true)) {
    if (entity is File && entity.path.endsWith('_cubit.dart')) {
      String content = await entity.readAsString();
      bool modified = false;

      if (postRegex.hasMatch(content)) {
        content = content.replaceAll(postRegex, "operation: 'post'");
        modified = true;
      }
      if (getRegex.hasMatch(content)) {
        content = content.replaceAll(getRegex, "operation: 'get'");
        modified = true;
      }
      if (putRegex.hasMatch(content)) {
        content = content.replaceAll(putRegex, "operation: 'put'");
        modified = true;
      }
      if (deleteRegex.hasMatch(content)) {
        content = content.replaceAll(deleteRegex, "operation: 'delete'");
        modified = true;
      }

      if (modified) {
        await entity.writeAsString(content);
        print('Updated: ${entity.path}');
      }
    }
  }
}
