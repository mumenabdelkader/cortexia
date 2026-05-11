import 'package:json_annotation/json_annotation.dart';

enum AlertSeverity {
  @JsonValue(0) high,
  @JsonValue(1) medium,
  @JsonValue(2) low,
  @JsonValue(3) critical,
  @JsonValue(4) info,
}
