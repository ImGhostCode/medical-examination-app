import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/features/medical_examine/business/entities/signal_entity.dart';

class SignalModel extends SignalEntity {
  SignalModel(
      {required super.code,
      super.value,
      super.display,
      super.unit,
      super.valueString,
      super.authored,
      super.performer,
      super.location,
      super.requester,
      super.unitRoot,
      super.organization,
      super.status});

  factory SignalModel.fromJson({required Map<String, dynamic> json}) {
    return SignalModel(
      code: json[kCode],
      value: json[kValue] ?? '',
      valueString: json[kValueString] ?? '',
      unit: json[kUnit] ?? '',
      display: json[kDisplay] ?? '',
      authored: json[kAuthored] ?? '',
      performer: json[kPerformer] ?? '',
      location: json[kLocation] ?? '',
      requester: json[kRequester] ?? '',
      unitRoot: json[kUnitRoot] ?? '',
      organization: json[kOrganization] ?? '',
      status: json[kStatus] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kCode: super.code,
      kValue: super.value,
      kValueString: super.valueString,
      kUnit: super.unit,
      kDisplay: super.display,
      kAuthored: super.authored,
      kPerformer: super.performer,
      kLocation: super.location,
      kRequester: super.requester,
      kUnitRoot: super.unitRoot,
      kOrganization: super.organization,
      kStatus: super.status,
    };
  }
}
