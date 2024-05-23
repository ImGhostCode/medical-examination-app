import 'package:flutter/material.dart';
import 'package:medical_examination_app/core/common/widgets.dart';
import 'package:medical_examination_app/features/patient/business/entities/health_insurance_card.dart';
import 'package:medical_examination_app/features/patient/business/entities/patient_entity.dart';

class CreatePatientProfilePage extends StatefulWidget {
  const CreatePatientProfilePage({super.key});

  @override
  State<CreatePatientProfilePage> createState() =>
      _CreatePatientProfilePageState();
}

enum ProfileType { healthInsurance, normal }

enum Gender { male, female }

class _CreatePatientProfilePageState extends State<CreatePatientProfilePage> {
  final _formKey = GlobalKey<FormState>();

  ProfileType _profileType = ProfileType.healthInsurance;
  Gender _selectedGender = Gender.male;

  HealthInsuranceCardEntity? _healthInsuranceCard;
  CiEntity? _patientCIEntity;
  final List<TelecomEntity> _patientTelecoms = [];
  AddressEntity? _patientAddress;
  final List<ContactEnitity> _contacts = [];
  ServicesEntity? _service;

  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          title: const Text('Tạo hồ sơ bệnh nhân'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: SegmentedButton<ProfileType>(
                            segments: const <ButtonSegment<ProfileType>>[
                              ButtonSegment<ProfileType>(
                                  value: ProfileType.healthInsurance,
                                  label: Text('BHYT'),
                                  icon: Icon(
                                    Icons.medical_information_outlined,
                                    size: 25,
                                  )),
                              ButtonSegment<ProfileType>(
                                  value: ProfileType.normal,
                                  label: Text('Thường'),
                                  icon: Icon(Icons.badge_outlined, size: 25)),
                            ],
                            selected: <ProfileType>{_profileType},
                            onSelectionChanged:
                                (Set<ProfileType> newSelection) {
                              setState(() {
                                _profileType = newSelection.first;
                              });
                            },
                          ),
                        ),

                        // Loại hồ sơ
                        const SizedBox(height: 20),
                        const LabelTextField(label: 'Loại hồ sơ'),
                        const SizedBox(height: 5),
                        DropdownButtonFormField(
                            style: Theme.of(context).textTheme.bodyMedium,
                            icon: const Icon(Icons.keyboard_arrow_down_rounded),
                            items: [
                              DropdownMenuItem(
                                value: 'new',
                                child: Text(
                                  'Cấp cứu',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'old',
                                child: Text(
                                  'Khám bệnh',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ],
                            onChanged: (value) {}),

                        //  Tên bệnh nhân
                        const SizedBox(height: 8),
                        const LabelTextField(label: 'Tên bệnh nhân'),
                        const SizedBox(height: 5),
                        TextFormField(
                          style: Theme.of(context).textTheme.bodyMedium,
                          decoration: const InputDecoration(
                              // hintText: 'Nhập tên bệnh nhân',
                              ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập tên bệnh nhân';
                            }
                            return null;
                          },
                        ),

                        // Ngày sinh
                        const SizedBox(height: 8),
                        const LabelTextField(label: 'Ngày sinh'),
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: TextEditingController(
                              text:
                                  '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'),
                          style: Theme.of(context).textTheme.bodyMedium,
                          readOnly: true,
                          decoration: InputDecoration(
                              // hintText: 'Nhập tên bệnh nhân',

                              suffixIcon: IconButton(
                                  onPressed: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: _selectedDate,
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now(),
                                    ).then((value) {
                                      if (value != null) {
                                        setState(() {
                                          _selectedDate = value;
                                        });
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    Icons.edit_calendar_rounded,
                                    color: Colors.grey.shade800,
                                  ))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập ngày sinh';
                            }
                            return null;
                          },
                        ),

                        // Giới tính
                        const SizedBox(height: 8),
                        const LabelTextField(label: 'Giới tính'),
                        // const SizedBox(height: 5),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                              child: RadioListTile<Gender>(
                                selected: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                title: Text(
                                  'Nam',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                value: Gender.male,
                                groupValue: _selectedGender,
                                onChanged: (Gender? value) {
                                  setState(() {
                                    _selectedGender = value!;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<Gender>(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                title: Text(
                                  'Nữ',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                value: Gender.female,
                                groupValue: _selectedGender,
                                onChanged: (Gender? value) {
                                  setState(() {
                                    _selectedGender = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),

                        // Thông tin thẻ BHYT
                        _profileType == ProfileType.healthInsurance
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const LabelTextField(
                                      label: 'Thông tin thẻ BHYT'),
                                  const SizedBox(height: 5),
                                  _healthInsuranceCard != null
                                      ? const SizedBox.shrink()
                                      : Row(
                                          children: [
                                            const Icon(Icons.add_rounded,
                                                color: Colors.blue),
                                            const SizedBox(width: 5),
                                            Text(
                                              'Thêm thẻ BHYT',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(color: Colors.blue),
                                            )
                                          ],
                                        ),
                                ],
                              )
                            : const SizedBox.shrink(),

                        // Thông tin thẻ CCCD
                        const SizedBox(height: 8),
                        const LabelTextField(label: 'Thông tin thẻ CCCD'),
                        const SizedBox(height: 5),
                        _patientCIEntity != null
                            ? const SizedBox.shrink()
                            : Row(
                                children: [
                                  const Icon(Icons.add_rounded,
                                      color: Colors.blue),
                                  const SizedBox(width: 5),
                                  Text(
                                    'Thêm thẻ CCCD',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: Colors.blue),
                                  )
                                ],
                              ),

                        // Dân tộc, quốc tịch, nghề nghiệp
                        const SizedBox(height: 8),
                        const LabelTextField(label: 'Dân tộc'),
                        const SizedBox(height: 5),
                        TextFormField(
                          readOnly: true,
                          initialValue: 'Kinh',
                          style: Theme.of(context).textTheme.bodyMedium,
                          decoration: const InputDecoration(
                              hintText: 'Nhập dân tộc',
                              suffixIcon:
                                  Icon(Icons.keyboard_arrow_down_rounded)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập dân tộc';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 8),
                        const LabelTextField(label: 'Quốc tịch'),
                        const SizedBox(height: 5),
                        TextFormField(
                          readOnly: true,
                          initialValue: 'Việt Nam',
                          style: Theme.of(context).textTheme.bodyMedium,
                          decoration: const InputDecoration(
                              hintText: 'Nhập quốc tịch',
                              suffixIcon:
                                  Icon(Icons.keyboard_arrow_down_rounded)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập quốc tịch';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 8),
                        const LabelTextField(label: 'Nghề nghiệp'),
                        const SizedBox(height: 5),
                        TextFormField(
                          readOnly: true,
                          initialValue: 'Kỹ sư xây dựng',
                          style: Theme.of(context).textTheme.bodyMedium,
                          decoration: const InputDecoration(
                              hintText: 'Nhập ngề nghiệp',
                              suffixIcon:
                                  Icon(Icons.keyboard_arrow_down_rounded)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập nghề nghiệp';
                            }
                            return null;
                          },
                        ),

                        // Thông tin liên lạc, Địa chỉ, thông tin liên lạc khẩn cấp,
                        const SizedBox(height: 8),
                        const LabelTextField(label: 'Thông tin liên lạc'),
                        const SizedBox(height: 5),
                        _patientTelecoms.isNotEmpty
                            ? const SizedBox.shrink()
                            : Row(
                                children: [
                                  const Icon(Icons.add_rounded,
                                      color: Colors.blue),
                                  const SizedBox(width: 5),
                                  Text(
                                    'Thêm thông tin liên lạc',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: Colors.blue),
                                  )
                                ],
                              ),
                        const SizedBox(height: 8),
                        const LabelTextField(label: 'Địa chỉ'),
                        const SizedBox(height: 5),
                        _patientAddress != null
                            ? const SizedBox.shrink()
                            : Row(
                                children: [
                                  const Icon(Icons.add_rounded,
                                      color: Colors.blue),
                                  const SizedBox(width: 5),
                                  Text(
                                    'Thêm địa chỉ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: Colors.blue),
                                  )
                                ],
                              ),
                        const SizedBox(height: 8),
                        const LabelTextField(
                            label: 'Thông tin liên lạc khẩn cấp'),
                        const SizedBox(height: 5),
                        _contacts.isNotEmpty
                            ? const SizedBox.shrink()
                            : Row(
                                children: [
                                  const Icon(Icons.add_rounded,
                                      color: Colors.blue),
                                  const SizedBox(width: 5),
                                  Text(
                                    'Thêm thông tin liên lạc khẩn cấp',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: Colors.blue),
                                  )
                                ],
                              ),

                        // Dịch vụ khám bệnh và điều trị
                        const SizedBox(height: 8),
                        const LabelTextField(
                            label: 'Dịch vụ khám bệnh và điều trị'),
                        const SizedBox(height: 5),
                        _service != null
                            ? const SizedBox.shrink()
                            : Row(
                                children: [
                                  const Icon(Icons.add_rounded,
                                      color: Colors.blue),
                                  const SizedBox(width: 5),
                                  Text(
                                    'Thêm dịch vụ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: Colors.blue),
                                  )
                                ],
                              ),

                        // Khu vực tiếp nhận
                        const SizedBox(height: 8),
                        const LabelTextField(label: 'Khu vực tiếp nhận'),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField(
                                items: [
                                  DropdownMenuItem(
                                    value: 'new',
                                    child: Text(
                                      'Khu vực 1',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 'old',
                                    child: Text(
                                      'Khu vực 2',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                ],
                                onChanged: (value) {},
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: TextFormField(
                              style: Theme.of(context).textTheme.bodyMedium,
                              decoration: const InputDecoration(
                                hintText: 'Số bàn tiếp nhận',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Vui lòng nhập bàn tiếp nhận';
                                }
                                return null;
                              },
                            ))
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // Submit form
                                }
                              },
                              child: const Text('Tạo hồ sơ')),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ));
  }
}
