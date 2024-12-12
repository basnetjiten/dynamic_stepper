import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_form_field/form/field.dart';

part 'task_model.freezed.dart';


@freezed
class StepContentModel with _$StepContentModel {
  const factory StepContentModel({
    Field<String?>? titleField,
    Field<String?>? timerField,
    String? image,
  }) = _StepContentModel;

}



