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
  final Function(int,int)? onStepDragged;

  final bool showContent;
  final bool enableSwipeAction;
  final bool isTitleOnlyStepper;
  final Widget? actionIcon;
  final bool enableDrag;

  @override
  Widget build(BuildContext context) {
    return DynamicStepper(
      enableSwipeAction: enableSwipeAction,
      alwaysShowContent: showContent,
      actionIcon: actionIcon,
      isTitleOnlyStepper: isTitleOnlyStepper,
      buildDefaultDragHandles: enableDrag,
      steps: steps,
      currentStep: 0,
      onStepDelete: (index) => onStepDeleted?.call(index),
      onStepDragged: (oldIndex,newIndex) => onStepDragged?.call(oldIndex,newIndex),
      controlsBuilder: (context, details) => const SizedBox(),
    );
  }
}
