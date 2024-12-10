import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_form_field/form/field.dart';
import 'package:simple_form_field/form/form_mixin.dart';
import 'package:simple_form_field/form/form_status.dart';

part 'therapist_availability_form_state.dart';

part 'therapist_availability_form_cubit.freezed.dart';

class TherapistAvailabilityFormCubit
    extends Cubit<TherapistAvailabilityFormState> {
  TherapistAvailabilityFormCubit()
      : super(TherapistAvailabilityFormState.initial());

  void onTitleChange(String consultationFee) {
    if (consultationFee.trim().isNotEmpty) {}
  }

  void addAnotherAvailable() {
    final List<StepContentModel> newSteps = List<StepContentModel>.from(state.steps)..add(StepContentModel());

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
    final List<StepContentModel> availableTime = List<StepContentModel>.from(state.steps);

    availableTime.add(StepContentModel(title: title,timer: timer));
  }

  void validateForm() {
    if (state.isValid) {}
  }

      List<StepContentModel> get stepsModel => state.steps;
}
