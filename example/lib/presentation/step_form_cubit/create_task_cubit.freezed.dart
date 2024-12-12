// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_task_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreateTaskState {
  List<StepContentModel?> get steps => throw _privateConstructorUsedError;
  FormStatus get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreateTaskStateCopyWith<CreateTaskState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateTaskStateCopyWith<$Res> {
  factory $CreateTaskStateCopyWith(
          CreateTaskState value, $Res Function(CreateTaskState) then) =
      _$CreateTaskStateCopyWithImpl<$Res, CreateTaskState>;
  @useResult
  $Res call({List<StepContentModel?> steps, FormStatus status});

  $FormStatusCopyWith<$Res> get status;
}

/// @nodoc
class _$CreateTaskStateCopyWithImpl<$Res, $Val extends CreateTaskState>
    implements $CreateTaskStateCopyWith<$Res> {
  _$CreateTaskStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? steps = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<StepContentModel?>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as FormStatus,
    ) as $Val);
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
abstract class _$$CreateTaskStateImplCopyWith<$Res>
    implements $CreateTaskStateCopyWith<$Res> {
  factory _$$CreateTaskStateImplCopyWith(_$CreateTaskStateImpl value,
          $Res Function(_$CreateTaskStateImpl) then) =
      __$$CreateTaskStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<StepContentModel?> steps, FormStatus status});

  @override
  $FormStatusCopyWith<$Res> get status;
}

/// @nodoc
class __$$CreateTaskStateImplCopyWithImpl<$Res>
    extends _$CreateTaskStateCopyWithImpl<$Res, _$CreateTaskStateImpl>
    implements _$$CreateTaskStateImplCopyWith<$Res> {
  __$$CreateTaskStateImplCopyWithImpl(
      _$CreateTaskStateImpl _value, $Res Function(_$CreateTaskStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? steps = null,
    Object? status = null,
  }) {
    return _then(_$CreateTaskStateImpl(
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<StepContentModel?>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as FormStatus,
    ));
  }
}

/// @nodoc

class _$CreateTaskStateImpl extends _CreateTaskState {
  const _$CreateTaskStateImpl(
      {required this.steps, this.status = const FormStatus.initial()})
      : super._();

  @override
  final List<StepContentModel?> steps;
  @override
  @JsonKey()
  final FormStatus status;

  @override
  String toString() {
    return 'CreateTaskState(steps: $steps, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateTaskStateImpl &&
            const DeepCollectionEquality().equals(other.steps, steps) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(steps), status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateTaskStateImplCopyWith<_$CreateTaskStateImpl> get copyWith =>
      __$$CreateTaskStateImplCopyWithImpl<_$CreateTaskStateImpl>(
          this, _$identity);
}

abstract class _CreateTaskState extends CreateTaskState {
  const factory _CreateTaskState(
      {required final List<StepContentModel?> steps,
      final FormStatus status}) = _$CreateTaskStateImpl;
  const _CreateTaskState._() : super._();

  @override
  List<StepContentModel?> get steps;
  @override
  FormStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$CreateTaskStateImplCopyWith<_$CreateTaskStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
