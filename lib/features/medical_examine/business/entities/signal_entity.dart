class SignalEntity {
  final String code;
  final String? value;
  final String? valueString;
  final String? unit;
  final String? display;
  final String? authored;
  SignalEntity({
    required this.code,
    this.value,
    this.valueString,
    this.unit,
    this.display,
    this.authored,
  });
}
