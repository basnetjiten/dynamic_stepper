// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'therapist_availability_form_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TherapistAvailabilityFormState {
  Field<String> get title => throw _privateConstructorUsedError;
  Field<String> get timer => throw _privateConstructorUsedError;
  List<StepContentModel> get steps => throw _privateConstructorUsedError;
  FormStatus get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TherapistAvailabilityFormStateCopyWith<TherapistAvailabilityFormState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TherapistAvailabilityFormStateCopyWith<$Res> {
  factory $TherapistAvailabilityFormStateCopyWith(
          TherapistAvailabilityFormState value,
          $Res Function(TherapistAvailabilityFormState) then) =
      _$TherapistAvailabilityFormStateCopyWithImpl<$Res,
          TherapistAvailabilityFormState>;
  @useResult
  $Res call(
      {Field<String> title,
      Field<String> timer,
      List<StepContentModel> steps,
      FormStatus status});

  $FieldCopyWith<String, $Res> get title;
  $FieldCopyWith<String, $Res> get timer;
  $FormStatusCopyWith<$Res> get status;
}

/// @nodoc
class _$TherapistAvailabilityFormStateCopyWithImpl<$Res,
        $Val extends TherapistAvailabilityFormState>
    implements $TherapistAvailabilityFormStateCopyWith<$Res> {
  _$TherapistAvailabilityFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? timer = null,
    Object? steps = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as Field<String>,
      timer: null == timer
          ? _value.timer
          : timer // ignore: cast_nullable_to_non_nullable
              as Field<String>,
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<StepContentModel>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as FormStatus,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FieldCopyWith<String, $Res> get title {
    return $FieldCopyWith<String, $Res>(_value.title, (value) {
      return _then(_value.copyWith(title: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $FieldCopyWith<String, $Res> get timer {
    return $FieldCopyWith<String, $Res>(_value.timer, (value) {
      return _then(_value.copyWith(timer: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $FormStatusCopyWith<$Res> get status {
    return $FormStatusCopyWith<$Res>(_value.status, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TherapistAvailabilityFormStateImplCopyWith<$Res>
    implements $TherapistAvailabilityFormStateCopyWith<$Res> {
  factory _$$TherapistAvailabilityFormStateImplCopyWith(
          _$TherapistAvailabilityFormStateImpl value,
          $Res Function(_$TherapistAvailabilityFormStateImpl) then) =
      __$$TherapistAvailabilityFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Field<String> title,
      Field<String> timer,
      List<StepContentModel> steps,
      FormStatus status});

  @override
  $FieldCopyWith<String, $Res> get title;
  @override
  $FieldCopyWith<String, $Res> get timer;
  @override
  $FormStatusCopyWith<$Res> get status;
}

/// @nodoc
class __$$TherapistAvailabilityFormStateImplCopyWithImpl<$Res>
    extends _$TherapistAvailabilityFormStateCopyWithImpl<$Res,
        _$TherapistAvailabilityFormStateImpl>
    implements _$$TherapistAvailabilityFormStateImplCopyWith<$Res> {
  __$$TherapistAvailabilityFormStateImplCopyWithImpl(
      _$TherapistAvailabilityFormStateImpl _value,
      $Res Function(_$TherapistAvailabilityFormStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? timer = null,
    Object? steps = null,
    Object? status = null,
  }) {
    return _then(_$TherapistAvailabilityFormStateImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as Field<String>,
      timer: null == timer
          ? _value.timer
          : timer // ignore: cast_nullable_to_non_nullable
              as Field<String>,
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<StepContentModel>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as FormStatus,
    ));
  }
}

/// @nodoc

class _$TherapistAvailabilityFormStateImpl
    extends _TherapistAvailabilityFormState {
  const _$TherapistAvailabilityFormStateImpl(
      {required this.title,
      required this.timer,
      required this.steps,
      this.status = const FormStatus.initial()})
      : super._();

  @override
  final Field<String> title;
  @override
  final Field<String> timer;
  @override
  final List<StepContentModel> steps;
  @override
  @JsonKey()
  final FormStatus status;

  @override
  String toString() {
    return 'TherapistAvailabilityFormState(title: $title, timer: $timer, steps: $steps, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TherapistAvailabilityFormStateImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.timer, timer) || other.timer == timer) &&
            const DeepCollectionEquality().equals(other.steps, steps) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, timer,
      const DeepCollectionEquality().hash(steps), status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TherapistAvailabilityFormStateImplCopyWith<
          _$TherapistAvailabilityFormStateImpl>
      get copyWith => __$$TherapistAvailabilityFormStateImplCopyWithImpl<
          _$TherapistAvailabilityFormStateImpl>(this, _$identity);
}

abstract class _TherapistAvailabilityFormState
    extends TherapistAvailabilityFormState {
  const factory _TherapistAvailabilityFormState(
      {required final Field<String> title,
      required final Field<String> timer,
      required final List<StepContentModel> steps,
      final FormStatus status}) = _$TherapistAvailabilityFormStateImpl;
  const _TherapistAvailabilityFormState._() : super._();

  @override
  Field<String> get title;
  @override
  Field<String> get timer;
  @override
  List<StepContentModel> get steps;
  @override
  FormStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$TherapistAvailabilityFormStateImplCopyWith<
          _$TherapistAvailabilityFormStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
