import 'package:json_annotation/json_annotation.dart';

enum FluidBalanceCategory {
  @JsonValue(0) intake,
  @JsonValue(1) output,
}
