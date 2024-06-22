// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:tiengviet/tiengviet.dart';

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

String codeToItemStreatmentSheet(String code) {
  switch (code) {
    case 'VST_0001':
      return 'Diễn biến bệnh';
    case 'VST_0002':
      return 'Chỉ định dịch vụ';
    case 'VST_0003':
      return 'Chỉ định thuốc';
    // case 'VST_0004':
    //   return 'Diễn biến bệnh';
    case 'VST_0005':
      return 'Theo dõi diễn biến';
    case 'VST_0006':
      return 'Y lệnh chăm sóc';
    default:
      return '';
  }
}

String workToRole(String work) {
  switch (work) {
    case 'doctor':
      return 'Bác sĩ';
    case 'nurse':
      return 'Y tá';
    case 'other':
      return 'Khác';
    default:
      return 'Không xác định';
  }
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

// Format currency function
String formatCurrency(int value) {
  return value.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
}

// Convert Report Code to Report Name
String codeToReport(String code) {
  switch (code) {
    case 'FEE_000':
      return 'Chưa phân loại';
    case 'FEE_001':
      return 'Thăm dò chức năng';
    case 'FEE_002':
      return 'X- Quang';
    case 'FEE_003':
      return 'Nội soi';
    case 'FEE_004':
      return 'PTTT';
    case 'FEE_005':
      return 'Siêu âm';
    case 'FEE_006':
      return 'XN Vi Sinh';
    case 'FEE_007':
      return 'XN Huyết học';
    case 'FEE_008':
      return 'XN Sinh Hóa';
    case 'FEE_009':
      return 'Giải phẫu bệnh';
    case 'FEE_010':
      return 'Vật lý trị liệu';
    case 'FEE_011':
      return 'khác';
    case 'FEE_012':
      return 'MÁU';
    case 'FEE_013':
      return 'Vật tư y tế';
    case 'FEE_014':
      return 'Dinh Dưỡng';
    case 'FEE_015':
      return 'Khám bệnh';
    case 'FEE_016':
      return 'Giường';
    case 'FEE_017':
      return 'Chụp CT';
    case 'FEE_018':
      return 'XQ-MRI';
    case 'FEE_021':
      return 'Thuốc';
    case 'FEE_019':
      return 'Oxy';
    case 'FEE_022':
      return 'Vận chuyển';
    case 'FEE_020':
      return 'Chụp DSA';
    case 'FEE_023':
      return 'Vật tư thanh toán theo tỉ lệ';
    case 'FEE_024':
      return 'Chẩn đoán hình ảnh (XHH)';
    case 'FEE_025':
      return 'Thuốc y học cổ truyền';
    case 'FEE_026':
      return 'Chế phẩm đông y';
    case 'FEE_27':
      return 'Dịch vụ kỹ thuật thanh toán theo tỉ lệ';
    case 'FEE_028':
      return 'Thuốc thanh toán theo tỉ lệ';
    case 'FEE_029':
      return 'Vật tư trong gói';
    case 'FEE_030':
      return 'Dịch vụ khám đi kèm';
    case 'FEE_031':
      return 'Điện tim';
    case 'FEE_032':
      return 'Điện não';
    case 'FEE_033':
      return 'Hóa chất';
    case 'FEE_034':
      return 'Dịch vụ điều trị ban ngày';
    case 'FEE_035':
      return 'Khám chuyên khoa';
    case 'FEE_036':
      return 'Điều trị, tham vấn tâm lý';
    case 'FEE_037':
      return 'Đo lưu huyết não';
    case 'FEE_038':
      return 'Test tâm lý';
    case 'FEE_039':
      return 'Chăm sóc bệnh nhân';
    case 'FEE_040':
      return 'Covid';
    case 'FEE_041':
      return 'Dịch truyền';
    default:
      return '';
  }
}

/* Data Report Code
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

// Convert DateTime to "2024-03-23 00:00:00"
String formatDateParam(DateTime date) {
  return date.toString().substring(0, 19);
}

String normalizeText(String text) {
  return TiengViet.parse(text.toLowerCase());
}
