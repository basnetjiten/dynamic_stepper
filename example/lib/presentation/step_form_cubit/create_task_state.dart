part of 'create_task_cubit.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class CreateTaskState with _$CreateTaskState {
  const CreateTaskState._();

  const factory CreateTaskState({
    required List<StepContentModel?> steps,
    @Default(FormStatus.initial()) FormStatus status,
  }) = _CreateTaskState;

  factory CreateTaskState.initial() => const CreateTaskState(
        status: FormStatus.initial(),
        steps: <StepContentModel>[],
      );
}
