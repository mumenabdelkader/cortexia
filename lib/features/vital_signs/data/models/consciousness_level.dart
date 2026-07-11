import 'package:json_annotation/json_annotation.dart';

enum ConsciousnessLevel {
  @JsonValue(0) alert,
  @JsonValue(1) voice,
  @JsonValue(2) pain,
  @JsonValue(3) unresponsive,
}
