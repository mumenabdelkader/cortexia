import 'package:json_annotation/json_annotation.dart';

enum CareInterventionType {
  @JsonValue(0) ivCannula,
  @JsonValue(1) urinaryCatheter,
  @JsonValue(2) ngTube,
  @JsonValue(3) centralLine,
  @JsonValue(4) woundDrain,
}
