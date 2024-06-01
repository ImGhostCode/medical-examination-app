class SignalEntity {
  final String code;
  final String? value;
  final String? valueString;
  final String? unit;
  final String? display;
  final String? authored;
  final String? performer;
  final String? location;
  final String? requester;
  final String? unitRoot;
  final String? organization;
  final String? status;

  SignalEntity({
    required this.code,
    this.value,
    this.valueString,
    this.unit,
    this.display,
    this.authored,
    this.performer,
    this.location,
    this.requester,
    this.unitRoot,
    this.organization,
    this.status,
  });
}


/*
{
            "id": "20ac77e0-5095-4e76-8549-9da88845c37b",
            "seq": "240319141456006438",
            "code": "SIG_03",
            "note": "",
            "unit": "độ C",
            "status": "final",
            "display": "Nhiệt độ",
            "authored": "2024-03-19 14:14:56.006451+07",
            "location": "PK Số 49",
            "performer": "Trương Anh Vũ",
            "requester": "",
            "unit_root": "",
            "organization": "Khoa Khám Bệnh",
            "value_string": "36"
        },
*/