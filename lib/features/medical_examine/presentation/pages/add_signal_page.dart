import 'package:flutter/material.dart';

enum BloodType { A, B, AB, O }

class AddSignalPage extends StatefulWidget {
  const AddSignalPage({super.key});

  @override
  State<AddSignalPage> createState() => _AddSignalPageState();
}

class _AddSignalPageState extends State<AddSignalPage> {
  bool _heartRateExpanded = true;
  bool _bloodPressureExpanded = true;
  bool _temperatureExpanded = true;
  bool _sp02Expanded = true;
  bool _respiratoryRateExpanded = true;
  bool _heightExpanded = true;
  bool _weightExpanded = true;
  bool _bloodTypeExpanded = true;

  final _formKey = GlobalKey<FormState>();
  final _heartRateFormKey = GlobalKey<FormState>();
  final _bloolPressureFormKey = GlobalKey<FormState>();
  final _temperatureFormKey = GlobalKey<FormState>();
  final _sp02FormKey = GlobalKey<FormState>();
  final _respiratoryRateFormKey = GlobalKey<FormState>();
  final _heightFormKey = GlobalKey<FormState>();
  final _weightFormKey = GlobalKey<FormState>();
  final _bloodTypeFormKey = GlobalKey<FormState>();
  BloodType _bloodType = BloodType.A;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Sinh hiệu',
          textAlign: TextAlign.center,
        ),
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
              ExpansionTile(
                  onExpansionChanged: (bool expanded) {
                    setState(() {
                      _heartRateExpanded = expanded;
                    });
                  },
                  initiallyExpanded: _heartRateExpanded,
                  collapsedShape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                      borderRadius: BorderRadius.circular(8)),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                      borderRadius: BorderRadius.circular(8)),
                  title: Text(
                    'Mạch',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  childrenPadding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  children: [
                    Form(
                      key: _heartRateFormKey,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                helperText: 'Đơn vị: lần/phút',
                                helperStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(fontStyle: FontStyle.italic),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Vui lòng điền vào chỗ trống';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (_heartRateFormKey.currentState!
                                      .validate()) {}
                                },
                                child: const Text('Lưu')),
                          )
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('80 lần/phút'),
                          titleTextStyle:
                              Theme.of(context).textTheme.bodyMedium,
                          subtitle: const Text('12/12/2021 12:00:44'),
                          subtitleTextStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontStyle: FontStyle.italic),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.edit_rounded,
                                    color: Colors.blue,
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.delete_rounded,
                                      color: Colors.red)),
                            ],
                          ),
                        );
                      },
                    ),
                  ]),
              const SizedBox(height: 16),
              ExpansionTile(
                  onExpansionChanged: (bool expanded) {
                    setState(() {
                      _bloodPressureExpanded = expanded;
                    });
                  },
                  initiallyExpanded: _bloodPressureExpanded,
                  collapsedShape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                      borderRadius: BorderRadius.circular(8)),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                      borderRadius: BorderRadius.circular(8)),
                  title: Text(
                    'Huyết áp',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  childrenPadding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  children: [
                    Form(
                      key: _bloolPressureFormKey,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                helperText: 'Đơn vị: mmHg',
                                helperStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(fontStyle: FontStyle.italic),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Vui lòng điền vào chỗ trống';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (_bloolPressureFormKey.currentState!
                                      .validate()) {}
                                },
                                child: const Text('Lưu')),
                          )
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('120/80 mmHg'),
                          titleTextStyle:
                              Theme.of(context).textTheme.bodyMedium,
                          subtitle: const Text('12/12/2021 12:00:44'),
                          subtitleTextStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontStyle: FontStyle.italic),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.edit_rounded,
                                    color: Colors.blue,
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.delete_rounded,
                                      color: Colors.red)),
                            ],
                          ),
                        );
                      },
                    ),
                  ]),
              const SizedBox(height: 16),
              ExpansionTile(
                  onExpansionChanged: (bool expanded) {
                    setState(() {
                      _sp02Expanded = expanded;
                    });
                  },
                  initiallyExpanded: _sp02Expanded,
                  collapsedShape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                      borderRadius: BorderRadius.circular(8)),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                      borderRadius: BorderRadius.circular(8)),
                  title: Text(
                    'SPO2',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  childrenPadding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  children: [
                    Form(
                      key: _sp02FormKey,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                helperText: 'Đơn vị: %',
                                helperStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(fontStyle: FontStyle.italic),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Vui lòng điền vào chỗ trống';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (_sp02FormKey.currentState!.validate()) {}
                                },
                                child: const Text('Lưu')),
                          )
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('98%'),
                          titleTextStyle:
                              Theme.of(context).textTheme.bodyMedium,
                          subtitle: const Text('12/12/2021 12:00:44'),
                          subtitleTextStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontStyle: FontStyle.italic),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.edit_rounded,
                                    color: Colors.blue,
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.delete_rounded,
                                      color: Colors.red)),
                            ],
                          ),
                        );
                      },
                    ),
                  ]),
              const SizedBox(height: 16),
              ExpansionTile(
                  onExpansionChanged: (bool expanded) {
                    setState(() {
                      _temperatureExpanded = expanded;
                    });
                  },
                  initiallyExpanded: _temperatureExpanded,
                  collapsedShape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                      borderRadius: BorderRadius.circular(8)),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                      borderRadius: BorderRadius.circular(8)),
                  title: Text(
                    'Nhiệt độ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  childrenPadding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  children: [
                    Form(
                      key: _temperatureFormKey,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                helperText: 'Đơn vị: độ C',
                                helperStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(fontStyle: FontStyle.italic),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Vui lòng điền vào chỗ trống';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (_temperatureFormKey.currentState!
                                      .validate()) {}
                                },
                                child: const Text('Lưu')),
                          )
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('36.5 độ C'),
                          titleTextStyle:
                              Theme.of(context).textTheme.bodyMedium,
                          subtitle: const Text('12/12/2021 12:00:44'),
                          subtitleTextStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontStyle: FontStyle.italic),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.edit_rounded,
                                    color: Colors.blue,
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.delete_rounded,
                                      color: Colors.red)),
                            ],
                          ),
                        );
                      },
                    ),
                  ]),
              const SizedBox(height: 16),
              ExpansionTile(
                  onExpansionChanged: (bool expanded) {
                    setState(() {
                      _respiratoryRateExpanded = expanded;
                    });
                  },
                  initiallyExpanded: _respiratoryRateExpanded,
                  collapsedShape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                      borderRadius: BorderRadius.circular(8)),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                      borderRadius: BorderRadius.circular(8)),
                  title: Text(
                    'Nhịp thở',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  childrenPadding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  children: [
                    Form(
                      key: _respiratoryRateFormKey,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                helperText: 'Đơn vị: lần/phút',
                                helperStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(fontStyle: FontStyle.italic),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Vui lòng điền vào chỗ trống';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (_respiratoryRateFormKey.currentState!
                                      .validate()) {}
                                },
                                child: const Text('Lưu')),
                          )
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('20 lần/phút'),
                          titleTextStyle:
                              Theme.of(context).textTheme.bodyMedium,
                          subtitle: const Text('12/12/2021 12:00:44'),
                          subtitleTextStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontStyle: FontStyle.italic),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.edit_rounded,
                                    color: Colors.blue,
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.delete_rounded,
                                      color: Colors.red)),
                            ],
                          ),
                        );
                      },
                    ),
                  ]),
              const SizedBox(height: 16),
              ExpansionTile(
                  onExpansionChanged: (bool expanded) {
                    setState(() {
                      _heightExpanded = expanded;
                    });
                  },
                  initiallyExpanded: _heightExpanded,
                  collapsedShape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                      borderRadius: BorderRadius.circular(8)),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                      borderRadius: BorderRadius.circular(8)),
                  title: Text(
                    'Chiều cao',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  childrenPadding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  children: [
                    Form(
                      key: _heightFormKey,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                helperText: 'Đơn vị: cm',
                                helperStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(fontStyle: FontStyle.italic),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Vui lòng điền vào chỗ trống';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (_heightFormKey.currentState!
                                      .validate()) {}
                                },
                                child: const Text('Lưu')),
                          )
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('160 cm'),
                          titleTextStyle:
                              Theme.of(context).textTheme.bodyMedium,
                          subtitle: const Text('12/12/2021 12:00:44'),
                          subtitleTextStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontStyle: FontStyle.italic),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.edit_rounded,
                                    color: Colors.blue,
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.delete_rounded,
                                      color: Colors.red)),
                            ],
                          ),
                        );
                      },
                    ),
                  ]),
              const SizedBox(height: 16),
              ExpansionTile(
                  onExpansionChanged: (bool expanded) {
                    setState(() {
                      _weightExpanded = expanded;
                    });
                  },
                  initiallyExpanded: _weightExpanded,
                  collapsedShape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                      borderRadius: BorderRadius.circular(8)),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                      borderRadius: BorderRadius.circular(8)),
                  title: Text(
                    'Cân nặng',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  childrenPadding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  children: [
                    Form(
                      key: _weightFormKey,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                helperText: 'Đơn vị: Kg',
                                helperStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(fontStyle: FontStyle.italic),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Vui lòng điền vào chỗ trống';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (_weightFormKey.currentState!
                                      .validate()) {}
                                },
                                child: const Text('Lưu')),
                          )
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('60 Kg'),
                          titleTextStyle:
                              Theme.of(context).textTheme.bodyMedium,
                          subtitle: const Text('12/12/2021 12:00:44'),
                          subtitleTextStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontStyle: FontStyle.italic),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.edit_rounded,
                                    color: Colors.blue,
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.delete_rounded,
                                      color: Colors.red)),
                            ],
                          ),
                        );
                      },
                    ),
                  ]),
              const SizedBox(height: 16),
              ExpansionTile(
                  onExpansionChanged: (bool expanded) {
                    setState(() {
                      _bloodTypeExpanded = expanded;
                    });
                  },
                  initiallyExpanded: _bloodTypeExpanded,
                  collapsedShape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                      borderRadius: BorderRadius.circular(8)),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                      borderRadius: BorderRadius.circular(8)),
                  title: Text(
                    'Nhóm máu',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  childrenPadding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  children: [
                    Form(
                      key: _bloodTypeFormKey,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: DropdownButtonFormField(
                                style: Theme.of(context).textTheme.bodyMedium,
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_rounded),
                                value: _bloodType,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Vui lòng chọn nhóm máu';
                                  }
                                  return null;
                                },
                                items: const [
                                  DropdownMenuItem(
                                    value: BloodType.A,
                                    child: Text('A'),
                                  ),
                                  DropdownMenuItem(
                                    value: BloodType.B,
                                    child: Text('B'),
                                  ),
                                  DropdownMenuItem(
                                    value: BloodType.AB,
                                    child: Text('AB'),
                                  ),
                                  DropdownMenuItem(
                                    value: BloodType.O,
                                    child: Text('O'),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _bloodType = value as BloodType;
                                  });
                                }),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (_weightFormKey.currentState!
                                      .validate()) {}
                                },
                                child: const Text('Lưu')),
                          )
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('A'),
                          titleTextStyle:
                              Theme.of(context).textTheme.bodyMedium,
                          subtitle: const Text('12/12/2021 12:00:44'),
                          subtitleTextStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontStyle: FontStyle.italic),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.edit_rounded,
                                    color: Colors.blue,
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.delete_rounded,
                                      color: Colors.red)),
                            ],
                          ),
                        );
                      },
                    ),
                  ]),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                  child: const Text('Hoàn tất'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
