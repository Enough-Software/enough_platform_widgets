import 'package:enough_platform_widgets/enough_platform_widgets.dart';
import 'package:flutter/material.dart';

/// A platform aware replacement for the material Stepper widget
class PlatformStepper extends StatelessWidget {
  final Key? widgetKey;
  final List<Step> steps;
  final ScrollPhysics? physics;
  final StepperType type;
  final int currentStep;
  final void Function(int)? onStepTapped;
  final void Function()? onStepContinue;
  final void Function()? onStepCancel;
  final Widget Function(BuildContext,
      {void Function()? onStepContinue,
      void Function()? onStepCancel})? controlsBuilder;

  const PlatformStepper(
      {Key? key,
      this.widgetKey,
      required this.steps,
      this.physics,
      this.type = StepperType.vertical,
      this.currentStep = 0,
      this.onStepTapped,
      this.onStepContinue,
      this.onStepCancel,
      this.controlsBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      material: (context, platform) => Stepper(
        key: widgetKey,
        steps: steps,
        physics: physics,
        type: type,
        currentStep: currentStep,
        onStepTapped: onStepTapped,
        onStepCancel: onStepCancel,
        onStepContinue: onStepContinue,
        controlsBuilder: controlsBuilder,
      ),
      cupertino: (context, platform) => CupertinoStepper(
        key: widgetKey,
        steps: steps,
        physics: physics,
        type: type,
        currentStep: currentStep,
        onStepTapped: onStepTapped,
        onStepCancel: onStepCancel,
        onStepContinue: onStepContinue,
        controlsBuilder: controlsBuilder,
      ),
    );
  }
}
