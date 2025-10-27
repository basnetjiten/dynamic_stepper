import 'package:dynamic_stepper/dynamic_stepper.dart';
import 'package:flutter/material.dart';

class DynamicStepperWidget extends StatelessWidget {
  const DynamicStepperWidget(
      {super.key,
      required this.steps,
      this.onStepDeleted,
      required this.showContent,
      required this.enableSwipeAction,
      this.isTitleOnlyStepper = false,
      this.actionIcon,
      this.enableDrag = true,
      this.onStepDragged});

  final List<DynamicStep> steps;

  final ValueChanged<int>? onStepDeleted;
  final Function(int, int)? onStepDragged;

  final bool showContent;
  final bool enableSwipeAction;
  final bool isTitleOnlyStepper;
  final Widget? actionIcon;
  final bool enableDrag;

  @override
  Widget build(BuildContext context) {
    return DynamicStepper(
      stepRadius: 18,
      dragLastWidget: false,
      enableDrag: true,
      physics: const AlwaysScrollableScrollPhysics(),
      enableSwipeAction: enableSwipeAction,
      alwaysShowContent: showContent,
      actionIcon: actionIcon,
      isTitleOnlyStepper: isTitleOnlyStepper,
      buildDefaultDragHandles: enableDrag,
      steps: steps,
      currentStep: 0,
      toggleWidget: Container(
        height: 100,
        width: 200,
        color: Colors.green,
      ),
      firstWidget: Center(
          child: Container(
        height: 100,
        width: 200,
        color: Colors.yellow,
      )),
      onStepDelete: (index) => onStepDeleted?.call(index),
      onStepDragged: (oldIndex, newIndex) =>
          onStepDragged?.call(oldIndex, newIndex),
      controlsBuilder: (context, details) => const SizedBox(),
    );
  }
}
