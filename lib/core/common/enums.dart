// ignore_for_file: constant_identifier_names

enum OET { OET_001, OET_002 }

enum VST { VST_0001, VST_0002, VST_0003, VST_0004, VST_0005, VST_0006 }

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

class SignalStatus {
  static const String NEW = 'new';
  static const String FINAL = 'final';
  static const String EDIT = 'edit';
  static const String CANCEL = 'cancel';

  // convert English to Vietnamese
  static String convert(String status) {
    switch (status) {
      case FINAL:
        return 'Cuối cùng';
      case EDIT:
        return 'Chỉnh sửa';
      case CANCEL:
        return 'Hủy bỏ';
      default:
        return '';
    }
  }
}

// enum BloodType { A_POS, A_NEG, B_POS, B_NEG, AB_POS, AB_NEG, O_POS, O_NEG }

List<String> bloodTypes = [
  'A/Rh+',
  'A/Rh-',
  'B/Rh+',
  'B/Rh-',
  'AB/Rh+',
  'AB/Rh-',
  'O/Rh+',
  'O/Rh-',
];
