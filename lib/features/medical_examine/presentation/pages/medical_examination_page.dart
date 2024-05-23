import 'package:flutter/material.dart';

class MedicalExaminationPage extends StatefulWidget {
  const MedicalExaminationPage({Key? key}) : super(key: key);

  @override
  State<MedicalExaminationPage> createState() => _MedicalExaminationPageState();
}

class _MedicalExaminationPageState extends State<MedicalExaminationPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Ghi nhận thông tin\nthăm khám',
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Stepper(
          currentStep: _index,
          onStepCancel: () {
            if (_index > 0) {
              setState(() {
                _index -= 1;
              });
            }
          },
          onStepContinue: () {
            if (_index <= 0) {
              setState(() {
                _index += 1;
              });
            }
          },
          onStepTapped: (int index) {
            setState(() {
              _index = index;
            });
          },
          steps: <Step>[
            Step(
              stepStyle: StepStyle(
                color: _index == 0 ? Colors.blue : Colors.grey,
              ),
              title: Text(
                'Sinh hiệu',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: _index == 0 ? Colors.blue : Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              content: Container(
                alignment: Alignment.centerLeft,
                child: const Text('Content for Step 1'),
              ),
            ),
            Step(
              stepStyle: StepStyle(
                color: _index == 1 ? Colors.blue : Colors.grey,
              ),
              title: Text(
                'Tờ điều trị',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: _index == 1 ? Colors.blue : Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              content: Text('Content for Step 2'),
            ),
            Step(
              stepStyle: StepStyle(
                color: _index == 2 ? Colors.blue : Colors.grey,
              ),
              title: Text(
                'Tờ chăm sóc',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: _index == 2 ? Colors.blue : Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              content: Text('Content for Step 2'),
            ),
          ],
        ));
  }
}
