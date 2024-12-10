part of 'therapist_availability_form_cubit.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class TherapistAvailabilityFormState
    with _$TherapistAvailabilityFormState, FormMixin {
  const TherapistAvailabilityFormState._();

  const factory TherapistAvailabilityFormState({
    required Field<String> title,
    required Field<String> timer,
    required List<StepContentModel> steps,
    @Default(FormStatus.initial()) FormStatus status,
  }) = _TherapistAvailabilityFormState;

  factory TherapistAvailabilityFormState.initial() =>
      const TherapistAvailabilityFormState(
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

class StepContentModel {
  StepContentModel({this.title, this.timer, this.image});

  String? title;
  String? timer;
  String? image;
}
