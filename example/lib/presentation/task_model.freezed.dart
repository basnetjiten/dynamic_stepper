// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StepContentModel {
  Field<String?>? get titleField => throw _privateConstructorUsedError;
  Field<String?>? get timerField => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StepContentModelCopyWith<StepContentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StepContentModelCopyWith<$Res> {
  factory $StepContentModelCopyWith(
          StepContentModel value, $Res Function(StepContentModel) then) =
      _$StepContentModelCopyWithImpl<$Res, StepContentModel>;
  @useResult
  $Res call(
      {Field<String?>? titleField, Field<String?>? timerField, String? image});

  $FieldCopyWith<String?, $Res>? get titleField;
  $FieldCopyWith<String?, $Res>? get timerField;
}

/// @nodoc
class _$StepContentModelCopyWithImpl<$Res, $Val extends StepContentModel>
    implements $StepContentModelCopyWith<$Res> {
  _$StepContentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? titleField = freezed,
    Object? timerField = freezed,
    Object? image = freezed,
  }) {
    return _then(_value.copyWith(
      titleField: freezed == titleField
          ? _value.titleField
          : titleField // ignore: cast_nullable_to_non_nullable
              as Field<String?>?,
      timerField: freezed == timerField
          ? _value.timerField
          : timerField // ignore: cast_nullable_to_non_nullable
              as Field<String?>?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FieldCopyWith<String?, $Res>? get titleField {
    if (_value.titleField == null) {
      return null;
    }

    return $FieldCopyWith<String?, $Res>(_value.titleField!, (value) {
      return _then(_value.copyWith(titleField: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $FieldCopyWith<String?, $Res>? get timerField {
    if (_value.timerField == null) {
      return null;
    }

    return $FieldCopyWith<String?, $Res>(_value.timerField!, (value) {
      return _then(_value.copyWith(timerField: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StepContentModelImplCopyWith<$Res>
    implements $StepContentModelCopyWith<$Res> {
  factory _$$StepContentModelImplCopyWith(_$StepContentModelImpl value,
          $Res Function(_$StepContentModelImpl) then) =
      __$$StepContentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Field<String?>? titleField, Field<String?>? timerField, String? image});

  @override
  $FieldCopyWith<String?, $Res>? get titleField;
  @override
  $FieldCopyWith<String?, $Res>? get timerField;
}

/// @nodoc
class __$$StepContentModelImplCopyWithImpl<$Res>
    extends _$StepContentModelCopyWithImpl<$Res, _$StepContentModelImpl>
    implements _$$StepContentModelImplCopyWith<$Res> {
  __$$StepContentModelImplCopyWithImpl(_$StepContentModelImpl _value,
      $Res Function(_$StepContentModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? titleField = freezed,
    Object? timerField = freezed,
    Object? image = freezed,
  }) {
    return _then(_$StepContentModelImpl(
      titleField: freezed == titleField
          ? _value.titleField
          : titleField // ignore: cast_nullable_to_non_nullable
              as Field<String?>?,
      timerField: freezed == timerField
          ? _value.timerField
          : timerField // ignore: cast_nullable_to_non_nullable
              as Field<String?>?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$StepContentModelImpl implements _StepContentModel {
  const _$StepContentModelImpl({this.titleField, this.timerField, this.image});

  @override
  final Field<String?>? titleField;
  @override
  final Field<String?>? timerField;
  @override
  final String? image;

  @override
  String toString() {
    return 'StepContentModel(titleField: $titleField, timerField: $timerField, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StepContentModelImpl &&
            (identical(other.titleField, titleField) ||
                other.titleField == titleField) &&
            (identical(other.timerField, timerField) ||
                other.timerField == timerField) &&
            (identical(other.image, image) || other.image == image));
  }

  @override
  int get hashCode => Object.hash(runtimeType, titleField, timerField, image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StepContentModelImplCopyWith<_$StepContentModelImpl> get copyWith =>
      __$$StepContentModelImplCopyWithImpl<_$StepContentModelImpl>(
          this, _$identity);
}

abstract class _StepContentModel implements StepContentModel {
  const factory _StepContentModel(
      {final Field<String?>? titleField,
      final Field<String?>? timerField,
      final String? image}) = _$StepContentModelImpl;

  @override
  Field<String?>? get titleField;
  @override
  Field<String?>? get timerField;
  @override
  String? get image;
  @override
  @JsonKey(ignore: true)
  _$$StepContentModelImplCopyWith<_$StepContentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
