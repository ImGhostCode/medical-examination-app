import 'package:flutter/material.dart';
import 'package:medical_examination_app/core/common/enums.dart';
import 'package:medical_examination_app/core/common/widgets.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/errors/failure.dart';
import 'package:medical_examination_app/features/medical_examine/business/entities/signal_entity.dart';
import 'package:medical_examination_app/features/medical_examine/presentation/providers/medical_examine_provider.dart';
import 'package:provider/provider.dart';

class SignalRow extends StatefulWidget {
  const SignalRow({
    super.key,
    required this.listSignals,
    required this.encounter,
    required this.request,
    required this.division,
  });

  final List<SignalEntity> listSignals;
  final int encounter;
  final int request;
  final int division;

  @override
  State<SignalRow> createState() => _SignalRowState();
}

class _SignalRowState extends State<SignalRow> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.listSignals.length,
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  '${widget.listSignals[index].valueString} ${widget.listSignals[index].unit}'),
              const SizedBox(width: 5),
              Text(
                '(${SignalStatus.convert(widget.listSignals[index].status!)})',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.grey),
              ),
            ],
          ),
          titleTextStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold),
          subtitle: Text(DateTime.parse(widget.listSignals[index].authored!)
              .toLocal()
              .toString()
              .substring(0, 19)),
          subtitleTextStyle: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontStyle: FontStyle.italic),
          trailing: widget.listSignals[index].status == SignalStatus.CANCEL
              ? null
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          _dialogModifyBuilder(
                            context,
                            'Sửa sinh hiệu',
                            widget.listSignals[index],
                            false,
                          );
                        },
                        icon: const Icon(
                          Icons.edit_rounded,
                          color: Colors.blue,
                        )),
                    IconButton(
                        onPressed: () {
                          _dialogModifyBuilder(
                            context,
                            'Xóa sinh hiệu',
                            widget.listSignals[index],
                            true,
                          );
                        },
                        icon: const Icon(
                          Icons.delete_rounded,
                          color: Colors.red,
                        )),
                  ],
                ),
        );
      },
    );
  }

  Future<void> _dialogModifyBuilder(
      BuildContext context, String title, SignalEntity signal, bool isRemove) {
    final modifyFormKey = GlobalKey<FormState>();
    String? editedBloodType = signal.code == SignalType.SIG_10.name
        ? signal.valueString
        : bloodTypes[0];
    final TextEditingController signalController =
        TextEditingController(text: signal.valueString);
    final TextEditingController noteController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text(title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold)),
            contentPadding: const EdgeInsets.all(16),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Form(
                      key: modifyFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!isRemove)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LabelTextField(label: signal.display!),
                                const SizedBox(height: 5),
                                signal.code == SignalType.SIG_10.name
                                    ? DropdownButtonFormField(
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down_rounded),
                                        value: editedBloodType,
                                        validator: (value) {
                                          if (value == null) {
                                            return 'Vui lòng chọn nhóm máu';
                                          }
                                          return null;
                                        },
                                        items: bloodTypes
                                            .map((e) => DropdownMenuItem(
                                                  value: e,
                                                  child: Text(e),
                                                ))
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            editedBloodType = value;
                                          });
                                        })
                                    : TextFormField(
                                        controller: signalController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          fillColor: Colors.grey.shade100,
                                          helperText: 'Đơn vị: ${signal.unit}',
                                          helperStyle: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  fontStyle: FontStyle.italic),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Vui lòng điền vào chỗ trống';
                                          }
                                          return null;
                                        },
                                      ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          if (isRemove)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const LabelTextField(label: 'Ghi chú'),
                                const SizedBox(height: 5),
                                TextFormField(
                                  controller: noteController,
                                  maxLines: 5,
                                  decoration: const InputDecoration(
                                    hintText: 'Nhập ghi chú',
                                    // suffixIcon: IconButton(
                                    //   icon: const Icon(
                                    //     Icons.mic,
                                    //     color: Colors.blue,
                                    //     size: 30,
                                    //   ),
                                    //   onPressed: () {
                                    //     // Add your microphone button functionality here
                                    //   },
                                    // ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Vui lòng điền vào chỗ trống';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                        ],
                      )),
                ],
              ),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade400,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Hủy bỏ'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isRemove ? Colors.red : Colors.blue,
                      ),
                      onPressed: Provider.of<MedicalExamineProvider>(context,
                                  listen: true)
                              .isLoading
                          ? null
                          : () async {
                              if (modifyFormKey.currentState!.validate()) {
                                final result =
                                    await Provider.of<MedicalExamineProvider>(
                                            context,
                                            listen: false)
                                        .eitherFailureOrModifySignal(
                                            SignalEntity(
                                              status: SignalStatus.EDIT,
                                              seq: signal.seq,
                                              code: signal.id!,
                                              value: signal.code ==
                                                      SignalType.SIG_10.name
                                                  ? editedBloodType
                                                  : signalController.text,
                                              valueString: signal.code ==
                                                      SignalType.SIG_10.name
                                                  ? editedBloodType
                                                  : signalController.text,
                                              unit: signal.unit,
                                            ),
                                            widget.encounter,
                                            widget.request,
                                            widget.division);

                                if (result.runtimeType == Failure) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          (result as Failure).errorMessage),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          (result as ResponseModel).message),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                  Navigator.of(context).pop();
                                }
                              }
                            },
                      child: Text(isRemove ? 'Xóa' : 'Lưu'),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
      },
    );
  }
}
