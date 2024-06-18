import 'package:medical_examination_app/core/constants/constants.dart';

class ResponseModel<D> {
  final D data;
  final String code;
  final String type;
  final String status;
  final String message;

  ResponseModel({
    this.code = '',
    this.type = '',
    this.status = '',
    this.message = '',
    required this.data,
  });

  factory ResponseModel.fromJson({
    required dynamic json,
    required D Function(dynamic) fromJsonD,
  }) {
    return ResponseModel(
      code: json?[kCode] ?? '',
      type: json?[kType] ?? '',
      status: json?[kStatus] ?? '',
      message: json?[kMessage] ?? '',
      data: fromJsonD(json[kData]),
    );
  }

  Map<String, dynamic> toJson({
    required dynamic Function(D) toJsonD,
  }) {
    return {
      kCode: code,
      kType: type,
      kStatus: status,
      kMessage: message,
      kData: toJsonD(data),
    };
  }
}

// class ResponseType {
//   static const String success = 'success';
//   static const String error = 'error';
//   static const String warning = 'warning';
// }
