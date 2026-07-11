import 'package:json_annotation/json_annotation.dart';

enum AlertStatus {
  @JsonValue(0) active,
  @JsonValue(1) dismissed,
  @JsonValue(2) overridden,
  @JsonValue(3) resolved,
}
