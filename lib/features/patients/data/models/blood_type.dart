import 'package:json_annotation/json_annotation.dart';

enum BloodType {
  @JsonValue(0) aPositive,
  @JsonValue(1) aNegative,
  @JsonValue(2) bPositive,
  @JsonValue(3) bNegative,
  @JsonValue(4) abPositive,
  @JsonValue(5) abNegative,
  @JsonValue(6) oPositive,
  @JsonValue(7) oNegative,
  @JsonValue(8) unknown,
}

extension BloodTypeDisplay on BloodType {
  String get displayLabel {
    switch (this) {
      case BloodType.aPositive:  return 'A+';
      case BloodType.aNegative:  return 'A−';
      case BloodType.bPositive:  return 'B+';
      case BloodType.bNegative:  return 'B−';
      case BloodType.abPositive: return 'AB+';
      case BloodType.abNegative: return 'AB−';
      case BloodType.oPositive:  return 'O+';
      case BloodType.oNegative:  return 'O−';
      case BloodType.unknown:    return '—';
    }
  }
}
