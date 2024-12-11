part of 'create_task_cubit.dart';


@Freezed(makeCollectionsUnmodifiable: false)
class CreateTaskState
    with _$CreateTaskState, FormMixin {
  const CreateTaskState._();

  const factory CreateTaskState({
    required Field<String> title,
    required Field<String> timer,
    required List<StepContentModel> steps,
    @Default(FormStatus.initial()) FormStatus status,
  }) = _CreateTaskState;

  factory CreateTaskState.initial() =>
      const CreateTaskState(
        status: FormStatus.initial(),
        title: Field<String>(value: ''),
        timer: Field<String>(value: ''),
        steps: <StepContentModel>[],
      );

  bool get valid => isValid;

  @override
  List<Field<dynamic>> get fields => <Field<dynamic>>[title, timer];

  @override
  Map<String, dynamic> get values => <String, dynamic>{};
}


