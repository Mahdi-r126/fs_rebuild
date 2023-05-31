import 'package:flutter/material.dart';
import 'package:freesms/presentation/pages/add_ads/widgets/section.dart';
import 'package:freesms/presentation/pages/add_ads/widgets/themes.dart';

class Steps extends StatefulWidget {
  const Steps({Key? key}) : super(key: key);

  @override
  State<Steps> createState() => _StepsState();
}

class _StepsState extends State<Steps> {
  // steps
  int _stepIndex = 0;

  List<Step> stepList() => [
        Step(
          state: _stepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _stepIndex >= 0,
          title: const Text('Section', style: TextStyle(fontSize: 12)),
// Your child widget goes here
          content: const Section(),
        ),
        Step(
          state: _stepIndex <= 1 ? StepState.editing : StepState.complete,
          isActive: _stepIndex >= 1,
          title: const Text('Theme', style: TextStyle(fontSize: 12)),
          content: const Themes(),
        ),
        Step(
            state: _stepIndex <= 2 ? StepState.editing : StepState.complete,
            isActive: _stepIndex >= 2,
            title: const Text('Content', style: TextStyle(fontSize: 12)),
            content: const Center(
              child: Text('1'),
            )),
        Step(
            state: StepState.complete,
            isActive: _stepIndex >= 3,
            title: const Text('Setting', style: TextStyle(fontSize: 12)),
            content: const Center(
              child: Text('1'),
            )),
      ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(canvasColor: Colors.white),
      child: Stepper(
        elevation: 0,
        type: StepperType.horizontal,
        steps: stepList(),
        currentStep: _stepIndex,
        onStepContinue: null,
        onStepCancel: null,
        controlsBuilder: (BuildContext ctx, ControlsDetails dtl) {
          return const Text('');
        },
        onStepTapped: (value) {
          setState(() {
            _stepIndex = value;
          });
        },
      ),
    );
  }
}
