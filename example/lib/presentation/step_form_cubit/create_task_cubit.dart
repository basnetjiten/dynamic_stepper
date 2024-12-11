import 'package:example/presentation/task_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_form_field/form_configs.dart';

part 'create_task_state.dart';

part 'create_task_cubit.freezed.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  CreateTaskCubit() : super(CreateTaskState.initial());

  void addAnotherAvailable() {
    final List<StepContentModel> newSteps =
        List<StepContentModel>.from(state.steps)..add(StepContentModel());

    emit(
      state.copyWith(
        steps: newSteps,
      ),
    );
    print("LENGHT ${newSteps.length}");
  }

  void addAvailableTime({
    required String title,
    required String timer,
  }) {
    final List<StepContentModel> availableTime =
        List<StepContentModel>.from(state.steps);

    availableTime.add(StepContentModel(title: title, timer: timer));
  }

  void validateForm() {
    if (state.isValid) {}
  }

  List<StepContentModel> get stepsModel => state.steps;

  // Update StepModel data in the list
  void updateStep(int index, String? title, String? timer) {
    final List<StepContentModel> updatedList =
        List<StepContentModel>.from(state.steps);

    updatedList[index] = StepContentModel(title: title, timer: timer);
    emit(state.copyWith(steps: updatedList));
  }

  void createSteps(int total) {
    List<StepContentModel> steps = List<StepContentModel>.generate(
      total - 1,
      (index) => StepContentModel(),
    );

    emit(state.copyWith(steps: steps));
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
