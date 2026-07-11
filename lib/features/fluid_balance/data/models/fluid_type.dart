import 'package:json_annotation/json_annotation.dart';

enum FluidType {
  @JsonValue(0) oral,
  @JsonValue(1) iv,
  @JsonValue(2) urine,
  @JsonValue(3) drain,
}
