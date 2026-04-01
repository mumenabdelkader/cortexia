import 'package:json_annotation/json_annotation.dart';

enum MedicationRoute {
  @JsonValue(0) oral,
  @JsonValue(1) iv,
  @JsonValue(2) im,
  @JsonValue(3) sc,
  @JsonValue(4) topical,
  @JsonValue(5) inhalation,
  @JsonValue(6) rectal,
}
