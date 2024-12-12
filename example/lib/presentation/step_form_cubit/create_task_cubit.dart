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
    emit(state.copyWith(status: const FormStatus.initial()));
    final List<StepContentModel> newSteps = _getModifiableSteps
      ..add(const StepContentModel(
          titleField: Field<String?>(value: null),
          timerField: Field<String?>(value: null)));

    emit(state.copyWith(steps: newSteps, status: const FormStatus.initial()));
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

  List<StepContentModel?> get storedSteps => state.steps;

  // Update StepModel data in the list

  void onStepFormChanged({required int index, String? timer, String? title}) {
    emit(state.copyWith(status: const FormStatus.initial()));
    final List<StepContentModel> updatedList = _getModifiableSteps;
    Field<String?>? titleField = updatedList[index].titleField;
    Field<String?>? timerField = updatedList[index].timerField;

      final timerValue = timer ?? timerField?.value;
      final titleValue = title ?? titleField?.value;

      timerField = timerField?.copyWith(
          value: timerValue, errorMessage: _getTimerErrorText(timerValue));

      titleField = titleField?.copyWith(
          value: titleValue, errorMessage: _getTitleErrorText(titleValue));

      updatedList[index] =
          StepContentModel(titleField: titleField, timerField: timerField);

      emit(state.copyWith(steps: updatedList));
    }
  }

  void saveSteps() {
    // Reset to initial status
    emit(state.copyWith(status: const FormStatus.initial()));

    // Flag to check if any step is invalid
    bool hasInvalidStep = false;

    // Update each step with error messages if invalid
    final updatedSteps = _getModifiableSteps.map((step) {
      final hasError =
          (step.timerField?.value == null) || (step.titleField?.value == null);

      if (hasError) {
        //print("jere $hasError");
        hasInvalidStep = true;
        return step.copyWith(
          titleField:
              step.titleField?.copyWith(errorMessage: 'Title is required'),
          timerField:
              step.timerField?.copyWith(errorMessage: 'Timer is required'),
        );
      } else {
        // print("hereee");
        hasInvalidStep = false;
        return step;
      }
    }).toList();

    // Emit an error state only if there are invalid steps

    //print(hasInvalidStep);
    if (hasInvalidStep) {
      emit(state.copyWith(
        steps: updatedSteps,
        status: const FormStatus.error(error: 'Please complete all the tasks'),
      ));
    } else {
      // If no errors, emit success or save state
      emit(state.copyWith(
        steps: updatedSteps,
        status: const FormStatus.success(),
      ));
      updatedSteps.forEach((step) {
        print("TITLE: ${step.titleField?.value}");
        print("TIMER: ${step.titleField?.value}");
      });
    }
  }

  // Get error text for the title field
  String? _getTitleErrorText(String? title) {
    return title == null
        ? null
        : (title.isEmpty)
            ? 'Title is required'
            : null;
  }

  // Get error text for the timer field
  String? _getTimerErrorText(String? timer) {
    return timer == null
        ? null
        : (timer.isEmpty)
            ? 'Timer is required'
            : null;
  }
}
