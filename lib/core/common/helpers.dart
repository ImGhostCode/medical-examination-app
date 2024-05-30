import 'dart:convert';

String paramToBase64(dynamic params) {
  if (params.runtimeType == String) {
    return base64Encode(utf8.encode(params));
  } else {
    String jsonStr = jsonEncode(params);
    String base64Str = base64Encode(utf8.encode(jsonStr));
    return base64Str;
  }
}

String codeToSignal(String code) {
  switch (code) {
    case 'SIG_02':
      return 'Mạch';
    case 'SIG_01':
      return 'Huyết áp';
    case 'SIG_03':
      return 'Nhiệt độ';
    case 'SIG_04':
      return 'SPO2';
    case 'SIG_05':
      return 'Nhịp thở';
    case 'SIG_08':
      return 'Chiều cao';
    case 'SIG_06':
      return 'Cân nặng';
    case 'SIG_10':
      return 'Nhóm máu';
    default:
      return '';
  }
}

enum SignalType {
  SIG_02,
  SIG_01,
  SIG_03,
  SIG_04,
  SIG_05,
  SIG_08,
  SIG_06,
  SIG_10,
}


/*
- Mạch: "code":"SIG_02", "unit":"lần/phút"

- Huyết áp: "code":"SIG_01" , "unit":"mmHg"

- Nhiệt độ: "code":"SIG_03", "unit":"độ C"

- SPO2: "code":"SIG_04", "unit":"%"

- Nhịp thở: "code":"SIG_05", "unit":"lần/phút"

- Chiều cao: "code":"SIG_08", "unit":"cm"

- Cân nặng: "code":"SIG_06", "unit":"Kg"

- Nhóm máu: "code":"SIG_10", "value_string":"O/Rh-" 
*/