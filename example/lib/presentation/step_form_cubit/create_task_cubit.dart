import 'package:example/presentation/task_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_form_field/form_configs.dart';

part 'create_task_state.dart';

part 'create_task_cubit.freezed.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  CreateTaskCubit() : super(CreateTaskState.initial());

  //Create a new empty steps and stores in a state
  void addNextStep() {
    final List<StepContentModel> newSteps = _getModifiableSteps
      ..add(StepContentModel());

    emit(state.copyWith(steps: newSteps));
  }

  //Update the value of dragged steps in UI with the steps stored in the state
  /// * [oldIndex] Represents the old index of Step in the UI before drag
  /// * [newIndex] Represents the new index of Step after dragging the step in the UI
  void onStepDragged(int oldIndex, int newIndex) {
    final List<StepContentModel> allSteps = _getModifiableSteps;

    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    StepContentModel reorderedStep = allSteps.removeAt(oldIndex);

    allSteps.insert(newIndex, reorderedStep);

    emit(state.copyWith(steps: allSteps));
  }

  List<StepContentModel> get _getModifiableSteps =>
      List<StepContentModel>.from(state.steps);

  void validateForm() {
    if (state.isValid) {

    }
  }

  List<StepContentModel> get storedSteps => state.steps;

  // Update StepModel data in the list
  void updateStep(int index, String? title, String? timer) {
    final List<StepContentModel> updatedList = _getModifiableSteps;

    updatedList[index] = StepContentModel(title: title, timer: timer);
    emit(state.copyWith(steps: updatedList));
  }

  void saveSteps() {
    bool isValid =
        state.steps.any((step) => step.timer != null && step.title != null);

    if (isValid) {
      for (var step in state.steps) {
        print("Title:${step.title} timer: ${step.timer}");
      }
    } else {
      emit(state.copyWith(
          status:
              const FormStatus.error(error: 'Please complete all the task')));
    }
  }
}
