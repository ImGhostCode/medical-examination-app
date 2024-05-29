import 'package:flutter/material.dart';
import 'package:medical_examination_app/features/medical_examine/business/entities/signal_entity.dart';

class EnteredSignalTable extends StatelessWidget {
  const EnteredSignalTable({
    super.key,
    required this.context,
    required this.listSignals,
  });

  final BuildContext context;
  final List<SignalEntity> listSignals;

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(
          color: Colors.grey.shade300, borderRadius: BorderRadius.circular(8)),
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        // Table header
        TableRow(
          children: [
            TableCell(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius:
                      const BorderRadius.only(topLeft: Radius.circular(8)),
                ),
                child: Text('Giá trị',
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
            ),
            TableCell(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius:
                      const BorderRadius.only(topRight: Radius.circular(8)),
                ),
                child: Text('Thời gian',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontStyle: FontStyle.italic)),
              ),
            ),
          ],
        ),
        ...List.generate(listSignals.length, (index) {
          return TableRow(children: [
            TableCell(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Text(
                    '${listSignals[index].valueString} ${listSignals[index].unit}',
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
            ),
            TableCell(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Text(
                    DateTime.parse(listSignals[index].authored!)
                        .toLocal()
                        .toString()
                        .substring(0, 19),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontStyle: FontStyle.italic)),
              ),
            ),
          ]);
        }).toList()
      ],
    );
  }
}
