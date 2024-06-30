// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum OET { OET_001, OET_002 }

enum OETTYPE { draft, publish }

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

class Unit {
  static const String MMHG = 'mmHg';
  static const String timePerMinute = 'lần/phút';
  static const String CELSIUS = 'độ C';
  static const String PERCENT = '%';
  static const String CM = 'cm';
  static const String KG = 'Kg';
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

class ServiceType {
  static const String BHYT = 'health_insurance';
  static const String fee = 'fee';
  static const String free = 'free';
  static const String other = 'other';
  static const String GOV_TT36 = 'GOV-TT36';

  static String convert(String type) {
    switch (type) {
      case BHYT:
        return 'BHYT';
      case fee:
        return 'Có phí';
      case free:
        return 'Miễn phí';
      case other:
        return 'Khác';
      case GOV_TT36:
        return 'GOV-TT36';
      default:
        return '';
    }
  }
}

// enum ServiceStatus { plan, publish, cancel, done }

class MedicalClass {
  static const String IMP = 'MRC.IMP';
  static const String AMP = 'MRC.AMP';
}

enum ISCard { on, off, none, allow, deny }

enum FeeOject { fee, insurance, required }

class ServiceStatus {
  static const String planned = 'plan';
  static const String finish = 'finish';
  static const String processing = 'processing';
  static const String waiting = 'waiting';
  static const String cancel = 'cancel';
  static const String cancelRequest = 'cancel request';
  static const String draft = 'draft';
  static const String approved = 'approve';
  static const String deliveried = 'deliveried';
  static const String rejected = 'rejected';
  static const String paymented = 'paymented';
  static const String replace = 'replace';
  static const String New = 'new';
  static const String payment = 'payment';
  static const String received = 'received';
  static const String publish = 'publish';
  static const String complete = 'complete';
  static const String all = 'all';
  static const String revoke = 'revoke';

  static String statusToVietnamese(String status) {
    switch (status) {
      case planned:
        return 'Chỉ định';
      case finish:
        return 'Hoàn thành';
      case processing:
        return 'Đang xử lý';
      case waiting:
        return 'Chờ phê duyệt';
      case cancel:
        return 'Đã hủy';
      case cancelRequest:
        return 'Yêu cầu hủy';
      case draft:
        return 'Chỉ định';
      case approved:
        return 'Đã phê duyệt';
      case deliveried:
        return 'Đã bàn giao';
      case rejected:
        return 'Bị từ chối';
      case paymented:
        return 'Đã thu/chi';
      case replace:
        return 'Thay thế bởi dịch vụ khác';
      case New:
        return 'Mới';
      case payment:
        return 'Đã thu/chi';
      case received:
        return 'Đã tiếp nhận';
      case publish:
        return 'Ban hành';
      case complete:
        return 'Hoàn thành';
      default:
        return '';
    }
  }

  static Color statusColor(String status) {
    switch (status) {
      case planned:
        return Colors.blue;
      case finish:
        return Colors.green;
      case processing:
        return Colors.orange;
      case waiting:
        return Colors.yellow;
      case cancel:
        return Colors.red;
      case cancelRequest:
        return Colors.red;
      case draft:
        return Colors.amber;
      case approved:
        return Colors.green;
      case deliveried:
        return Colors.green;
      case rejected:
        return Colors.red;
      case paymented:
        return Colors.green;
      case replace:
        return Colors.red;
      case New:
        return Colors.blue;
      case payment:
        return Colors.green;
      case received:
        return Colors.green;
      case publish:
        return Colors.green;
      case complete:
        return Colors.green;
      default:
        return Colors.black;
    }
  }

  static IconData statusIcon(String status) {
    switch (status) {
      case planned:
        return Icons.schedule;
      case finish:
        return Icons.check_circle;
      case processing:
        return Icons.autorenew;
      case waiting:
        return Icons.hourglass_empty;
      case cancel:
        return Icons.cancel;
      case cancelRequest:
        return Icons.cancel;
      case draft:
        return Icons.drafts;
      case approved:
        return Icons.assignment_turned_in_outlined;
      case deliveried:
        return Icons.check_circle;
      case rejected:
        return Icons.cancel;
      case paymented:
        return Icons.check_circle;
      case replace:
        return Icons.cancel;
      case New:
        return Icons.new_releases;
      case payment:
        return Icons.check_circle;
      case received:
        return Icons.check_circle;
      case publish:
        return Icons.check_circle;
      case complete:
        return Icons.check_rounded;
      default:
        return Icons.error;
    }
  }
}

/* ServiceStatus
planned		Chỉ định
finish		Hoàn thành
processing		Đang xử lý
waiting		Chờ phê duyệt
cancel		Đã hủy
cancel request		Yêu cầu hủy
draft		Khởi tạo
approved		Đã phê duyệt
deliveried		Đã bàn giao
rejected		Bị từ chối
paymented		Đã thu/chi
replace		Thay thế bởi dịch vụ khác
new		Mới
payment		Đã thu/chi
received		Đã tiếp nhận
*/

/* List of subclinic service
Code Name
FEE_000	Chưa phân loại
FEE_001	Thăm dò chức năng
FEE_002	X- Quang
FEE_003	Nội soi
FEE_004	PTTT
FEE_005	Siêu âm
FEE_006	XN Vi Sinh
FEE_007	XN Huyết học
FEE_008	XN Sinh Hóa
FEE_009	Giải phẫu bệnh
FEE_010	Vật lý trị liệu
FEE_011	khác
FEE_012	MÁU
FEE_013	Vật tư y tế
FEE_014	Dinh Dưỡng
FEE_015	Khám bệnh
FEE_016	Giường
FEE_017	Chụp CT
FEE_018	XQ-MRI
FEE_021	Thuốc
FEE_019	Oxy
FEE_022	Vận chuyển
FEE_020	Chụp DSA
FEE_023	Vật tư thanh toán theo tỉ lệ
FEE_024	Chẩn đoán hình ảnh (XHH)
FEE_025	Thuốc y học cổ truyền
FEE_026	Chế phẩm đông y
FEE_027	Dịch vụ kỹ thuật thanh toán theo tỉ lệ
FEE_028	Thuốc thanh toán theo tỉ lệ
FEE_029	Vật tư trong gói
FEE_030	Dịch vụ khám đi kèm
FEE_031	Điện tim
FEE_032	Điện não
FEE_033	Hóa chất
FEE_034	Dịch vụ điều trị ban ngày
FEE_035	Khám chuyên khoa
FEE_036	Điều trị, tham vấn tâm lý
FEE_037	Đo lưu huyết não
FEE_038	Test tâm lý
FEE_039	Chăm sóc bệnh nhân
FEE_040	Covid
FEE_041	Dịch truyền
*/

class EnumSubclinicService {
  final String code;
  final String display;

  EnumSubclinicService({required this.code, required this.display});
}

final List<EnumSubclinicService> enumSubclinicServices = [
  EnumSubclinicService(code: 'FEE_039', display: 'Chăm sóc bệnh nhân'),
  EnumSubclinicService(code: 'FEE_024', display: 'Chẩn đoán hình ảnh (XHH)'),
  EnumSubclinicService(code: 'FEE_001', display: 'Thăm dò chức năng'),
  EnumSubclinicService(code: 'FEE_026', display: 'Chế phẩm đông y'),
  EnumSubclinicService(code: 'FEE_017', display: 'Chụp CT'),
  EnumSubclinicService(code: 'FEE_002', display: 'X- Quang'),
  EnumSubclinicService(code: 'FEE_003', display: 'Nội soi'),
  EnumSubclinicService(code: 'FEE_004', display: 'PTTT'),
  EnumSubclinicService(code: 'FEE_005', display: 'Siêu âm'),
  EnumSubclinicService(code: 'FEE_006', display: 'XN Vi Sinh'),
  EnumSubclinicService(code: 'FEE_007', display: 'XN Huyết học'),
  EnumSubclinicService(code: 'FEE_008', display: 'XN Sinh Hóa'),
  EnumSubclinicService(code: 'FEE_009', display: 'Giải phẫu bệnh'),
  EnumSubclinicService(code: 'FEE_010', display: 'Vật lý trị liệu'),
  EnumSubclinicService(code: 'FEE_012', display: 'MÁU'),
  EnumSubclinicService(code: 'FEE_013', display: 'Vật tư y tế'),
  EnumSubclinicService(code: 'FEE_014', display: 'Dinh Dưỡng'),
  EnumSubclinicService(code: 'FEE_015', display: 'Khám bệnh'),
  EnumSubclinicService(code: 'FEE_016', display: 'Giường'),
  EnumSubclinicService(code: 'FEE_018', display: 'XQ-MRI'),
  EnumSubclinicService(code: 'FEE_021', display: 'Thuốc'),
  EnumSubclinicService(code: 'FEE_019', display: 'Oxy'),
  EnumSubclinicService(code: 'FEE_022', display: 'Vận chuyển'),
  EnumSubclinicService(code: 'FEE_020', display: 'Chụp DSA'),
  EnumSubclinicService(
      code: 'FEE_023', display: 'Vật tư thanh toán theo tỉ lệ'),
  EnumSubclinicService(code: 'FEE_025', display: 'Thuốc y học cổ truyền'),
  EnumSubclinicService(
      code: 'FEE_027', display: 'Dịch vụ kỹ thuật thanh toán theo tỉ lệ'),
  EnumSubclinicService(code: 'FEE_028', display: 'Thuốc thanh toán theo tỉ lệ'),
  EnumSubclinicService(code: 'FEE_029', display: 'Vật tư trong gói'),
  EnumSubclinicService(code: 'FEE_030', display: 'Dịch vụ khám đi kèm'),
  EnumSubclinicService(code: 'FEE_031', display: 'Điện tim'),
  EnumSubclinicService(code: 'FEE_032', display: 'Điện não'),
  EnumSubclinicService(code: 'FEE_033', display: 'Hóa chất'),
  EnumSubclinicService(code: 'FEE_034', display: 'Dịch vụ điều trị ban ngày'),
  EnumSubclinicService(code: 'FEE_035', display: 'Khám chuyên khoa'),
  EnumSubclinicService(code: 'FEE_036', display: 'Điều trị, tham vấn tâm lý'),
  EnumSubclinicService(code: 'FEE_037', display: 'Đo lưu huyết não'),
  EnumSubclinicService(code: 'FEE_038', display: 'Test tâm lý'),
  EnumSubclinicService(code: 'FEE_040', display: 'Covid'),
  EnumSubclinicService(code: 'FEE_041', display: 'Dịch truyền'),
];
