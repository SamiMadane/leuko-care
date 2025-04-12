// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AdminHomeState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() homeStateInitial,
    required TResult Function() getDoctorsStateLoading,
    required TResult Function(List<DoctorModel> doctors) getDoctorsStateSuccess,
    required TResult Function(String message) getDoctorsStateError,
    required TResult Function() getPatientsStateLoading,
    required TResult Function(List<PatientModel> patients)
    getPatientsStateSuccess,
    required TResult Function(String message) getPatientsStateError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? homeStateInitial,
    TResult? Function()? getDoctorsStateLoading,
    TResult? Function(List<DoctorModel> doctors)? getDoctorsStateSuccess,
    TResult? Function(String message)? getDoctorsStateError,
    TResult? Function()? getPatientsStateLoading,
    TResult? Function(List<PatientModel> patients)? getPatientsStateSuccess,
    TResult? Function(String message)? getPatientsStateError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? homeStateInitial,
    TResult Function()? getDoctorsStateLoading,
    TResult Function(List<DoctorModel> doctors)? getDoctorsStateSuccess,
    TResult Function(String message)? getDoctorsStateError,
    TResult Function()? getPatientsStateLoading,
    TResult Function(List<PatientModel> patients)? getPatientsStateSuccess,
    TResult Function(String message)? getPatientsStateError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_HomeStateInitial value) homeStateInitial,
    required TResult Function(GetDoctorsStateLoading value)
    getDoctorsStateLoading,
    required TResult Function(GetDoctorsStateSuccess value)
    getDoctorsStateSuccess,
    required TResult Function(GetDoctorsStateError value) getDoctorsStateError,
    required TResult Function(GetPatientsStateLoading value)
    getPatientsStateLoading,
    required TResult Function(GetPatientsStateSuccess value)
    getPatientsStateSuccess,
    required TResult Function(GetPatientsStateError value)
    getPatientsStateError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_HomeStateInitial value)? homeStateInitial,
    TResult? Function(GetDoctorsStateLoading value)? getDoctorsStateLoading,
    TResult? Function(GetDoctorsStateSuccess value)? getDoctorsStateSuccess,
    TResult? Function(GetDoctorsStateError value)? getDoctorsStateError,
    TResult? Function(GetPatientsStateLoading value)? getPatientsStateLoading,
    TResult? Function(GetPatientsStateSuccess value)? getPatientsStateSuccess,
    TResult? Function(GetPatientsStateError value)? getPatientsStateError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_HomeStateInitial value)? homeStateInitial,
    TResult Function(GetDoctorsStateLoading value)? getDoctorsStateLoading,
    TResult Function(GetDoctorsStateSuccess value)? getDoctorsStateSuccess,
    TResult Function(GetDoctorsStateError value)? getDoctorsStateError,
    TResult Function(GetPatientsStateLoading value)? getPatientsStateLoading,
    TResult Function(GetPatientsStateSuccess value)? getPatientsStateSuccess,
    TResult Function(GetPatientsStateError value)? getPatientsStateError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminHomeStateCopyWith<$Res> {
  factory $AdminHomeStateCopyWith(
    AdminHomeState value,
    $Res Function(AdminHomeState) then,
  ) = _$AdminHomeStateCopyWithImpl<$Res, AdminHomeState>;
}

/// @nodoc
class _$AdminHomeStateCopyWithImpl<$Res, $Val extends AdminHomeState>
    implements $AdminHomeStateCopyWith<$Res> {
  _$AdminHomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminHomeState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$HomeStateInitialImplCopyWith<$Res> {
  factory _$$HomeStateInitialImplCopyWith(
    _$HomeStateInitialImpl value,
    $Res Function(_$HomeStateInitialImpl) then,
  ) = __$$HomeStateInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$HomeStateInitialImplCopyWithImpl<$Res>
    extends _$AdminHomeStateCopyWithImpl<$Res, _$HomeStateInitialImpl>
    implements _$$HomeStateInitialImplCopyWith<$Res> {
  __$$HomeStateInitialImplCopyWithImpl(
    _$HomeStateInitialImpl _value,
    $Res Function(_$HomeStateInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminHomeState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$HomeStateInitialImpl implements _HomeStateInitial {
  const _$HomeStateInitialImpl();

  @override
  String toString() {
    return 'AdminHomeState.homeStateInitial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$HomeStateInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() homeStateInitial,
    required TResult Function() getDoctorsStateLoading,
    required TResult Function(List<DoctorModel> doctors) getDoctorsStateSuccess,
    required TResult Function(String message) getDoctorsStateError,
    required TResult Function() getPatientsStateLoading,
    required TResult Function(List<PatientModel> patients)
    getPatientsStateSuccess,
    required TResult Function(String message) getPatientsStateError,
  }) {
    return homeStateInitial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? homeStateInitial,
    TResult? Function()? getDoctorsStateLoading,
    TResult? Function(List<DoctorModel> doctors)? getDoctorsStateSuccess,
    TResult? Function(String message)? getDoctorsStateError,
    TResult? Function()? getPatientsStateLoading,
    TResult? Function(List<PatientModel> patients)? getPatientsStateSuccess,
    TResult? Function(String message)? getPatientsStateError,
  }) {
    return homeStateInitial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? homeStateInitial,
    TResult Function()? getDoctorsStateLoading,
    TResult Function(List<DoctorModel> doctors)? getDoctorsStateSuccess,
    TResult Function(String message)? getDoctorsStateError,
    TResult Function()? getPatientsStateLoading,
    TResult Function(List<PatientModel> patients)? getPatientsStateSuccess,
    TResult Function(String message)? getPatientsStateError,
    required TResult orElse(),
  }) {
    if (homeStateInitial != null) {
      return homeStateInitial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_HomeStateInitial value) homeStateInitial,
    required TResult Function(GetDoctorsStateLoading value)
    getDoctorsStateLoading,
    required TResult Function(GetDoctorsStateSuccess value)
    getDoctorsStateSuccess,
    required TResult Function(GetDoctorsStateError value) getDoctorsStateError,
    required TResult Function(GetPatientsStateLoading value)
    getPatientsStateLoading,
    required TResult Function(GetPatientsStateSuccess value)
    getPatientsStateSuccess,
    required TResult Function(GetPatientsStateError value)
    getPatientsStateError,
  }) {
    return homeStateInitial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_HomeStateInitial value)? homeStateInitial,
    TResult? Function(GetDoctorsStateLoading value)? getDoctorsStateLoading,
    TResult? Function(GetDoctorsStateSuccess value)? getDoctorsStateSuccess,
    TResult? Function(GetDoctorsStateError value)? getDoctorsStateError,
    TResult? Function(GetPatientsStateLoading value)? getPatientsStateLoading,
    TResult? Function(GetPatientsStateSuccess value)? getPatientsStateSuccess,
    TResult? Function(GetPatientsStateError value)? getPatientsStateError,
  }) {
    return homeStateInitial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_HomeStateInitial value)? homeStateInitial,
    TResult Function(GetDoctorsStateLoading value)? getDoctorsStateLoading,
    TResult Function(GetDoctorsStateSuccess value)? getDoctorsStateSuccess,
    TResult Function(GetDoctorsStateError value)? getDoctorsStateError,
    TResult Function(GetPatientsStateLoading value)? getPatientsStateLoading,
    TResult Function(GetPatientsStateSuccess value)? getPatientsStateSuccess,
    TResult Function(GetPatientsStateError value)? getPatientsStateError,
    required TResult orElse(),
  }) {
    if (homeStateInitial != null) {
      return homeStateInitial(this);
    }
    return orElse();
  }
}

abstract class _HomeStateInitial implements AdminHomeState {
  const factory _HomeStateInitial() = _$HomeStateInitialImpl;
}

/// @nodoc
abstract class _$$GetDoctorsStateLoadingImplCopyWith<$Res> {
  factory _$$GetDoctorsStateLoadingImplCopyWith(
    _$GetDoctorsStateLoadingImpl value,
    $Res Function(_$GetDoctorsStateLoadingImpl) then,
  ) = __$$GetDoctorsStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GetDoctorsStateLoadingImplCopyWithImpl<$Res>
    extends _$AdminHomeStateCopyWithImpl<$Res, _$GetDoctorsStateLoadingImpl>
    implements _$$GetDoctorsStateLoadingImplCopyWith<$Res> {
  __$$GetDoctorsStateLoadingImplCopyWithImpl(
    _$GetDoctorsStateLoadingImpl _value,
    $Res Function(_$GetDoctorsStateLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminHomeState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$GetDoctorsStateLoadingImpl implements GetDoctorsStateLoading {
  const _$GetDoctorsStateLoadingImpl();

  @override
  String toString() {
    return 'AdminHomeState.getDoctorsStateLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetDoctorsStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() homeStateInitial,
    required TResult Function() getDoctorsStateLoading,
    required TResult Function(List<DoctorModel> doctors) getDoctorsStateSuccess,
    required TResult Function(String message) getDoctorsStateError,
    required TResult Function() getPatientsStateLoading,
    required TResult Function(List<PatientModel> patients)
    getPatientsStateSuccess,
    required TResult Function(String message) getPatientsStateError,
  }) {
    return getDoctorsStateLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? homeStateInitial,
    TResult? Function()? getDoctorsStateLoading,
    TResult? Function(List<DoctorModel> doctors)? getDoctorsStateSuccess,
    TResult? Function(String message)? getDoctorsStateError,
    TResult? Function()? getPatientsStateLoading,
    TResult? Function(List<PatientModel> patients)? getPatientsStateSuccess,
    TResult? Function(String message)? getPatientsStateError,
  }) {
    return getDoctorsStateLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? homeStateInitial,
    TResult Function()? getDoctorsStateLoading,
    TResult Function(List<DoctorModel> doctors)? getDoctorsStateSuccess,
    TResult Function(String message)? getDoctorsStateError,
    TResult Function()? getPatientsStateLoading,
    TResult Function(List<PatientModel> patients)? getPatientsStateSuccess,
    TResult Function(String message)? getPatientsStateError,
    required TResult orElse(),
  }) {
    if (getDoctorsStateLoading != null) {
      return getDoctorsStateLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_HomeStateInitial value) homeStateInitial,
    required TResult Function(GetDoctorsStateLoading value)
    getDoctorsStateLoading,
    required TResult Function(GetDoctorsStateSuccess value)
    getDoctorsStateSuccess,
    required TResult Function(GetDoctorsStateError value) getDoctorsStateError,
    required TResult Function(GetPatientsStateLoading value)
    getPatientsStateLoading,
    required TResult Function(GetPatientsStateSuccess value)
    getPatientsStateSuccess,
    required TResult Function(GetPatientsStateError value)
    getPatientsStateError,
  }) {
    return getDoctorsStateLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_HomeStateInitial value)? homeStateInitial,
    TResult? Function(GetDoctorsStateLoading value)? getDoctorsStateLoading,
    TResult? Function(GetDoctorsStateSuccess value)? getDoctorsStateSuccess,
    TResult? Function(GetDoctorsStateError value)? getDoctorsStateError,
    TResult? Function(GetPatientsStateLoading value)? getPatientsStateLoading,
    TResult? Function(GetPatientsStateSuccess value)? getPatientsStateSuccess,
    TResult? Function(GetPatientsStateError value)? getPatientsStateError,
  }) {
    return getDoctorsStateLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_HomeStateInitial value)? homeStateInitial,
    TResult Function(GetDoctorsStateLoading value)? getDoctorsStateLoading,
    TResult Function(GetDoctorsStateSuccess value)? getDoctorsStateSuccess,
    TResult Function(GetDoctorsStateError value)? getDoctorsStateError,
    TResult Function(GetPatientsStateLoading value)? getPatientsStateLoading,
    TResult Function(GetPatientsStateSuccess value)? getPatientsStateSuccess,
    TResult Function(GetPatientsStateError value)? getPatientsStateError,
    required TResult orElse(),
  }) {
    if (getDoctorsStateLoading != null) {
      return getDoctorsStateLoading(this);
    }
    return orElse();
  }
}

abstract class GetDoctorsStateLoading implements AdminHomeState {
  const factory GetDoctorsStateLoading() = _$GetDoctorsStateLoadingImpl;
}

/// @nodoc
abstract class _$$GetDoctorsStateSuccessImplCopyWith<$Res> {
  factory _$$GetDoctorsStateSuccessImplCopyWith(
    _$GetDoctorsStateSuccessImpl value,
    $Res Function(_$GetDoctorsStateSuccessImpl) then,
  ) = __$$GetDoctorsStateSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<DoctorModel> doctors});
}

/// @nodoc
class __$$GetDoctorsStateSuccessImplCopyWithImpl<$Res>
    extends _$AdminHomeStateCopyWithImpl<$Res, _$GetDoctorsStateSuccessImpl>
    implements _$$GetDoctorsStateSuccessImplCopyWith<$Res> {
  __$$GetDoctorsStateSuccessImplCopyWithImpl(
    _$GetDoctorsStateSuccessImpl _value,
    $Res Function(_$GetDoctorsStateSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminHomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? doctors = null}) {
    return _then(
      _$GetDoctorsStateSuccessImpl(
        null == doctors
            ? _value._doctors
            : doctors // ignore: cast_nullable_to_non_nullable
                as List<DoctorModel>,
      ),
    );
  }
}

/// @nodoc

class _$GetDoctorsStateSuccessImpl implements GetDoctorsStateSuccess {
  const _$GetDoctorsStateSuccessImpl(final List<DoctorModel> doctors)
    : _doctors = doctors;

  final List<DoctorModel> _doctors;
  @override
  List<DoctorModel> get doctors {
    if (_doctors is EqualUnmodifiableListView) return _doctors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_doctors);
  }

  @override
  String toString() {
    return 'AdminHomeState.getDoctorsStateSuccess(doctors: $doctors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetDoctorsStateSuccessImpl &&
            const DeepCollectionEquality().equals(other._doctors, _doctors));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_doctors));

  /// Create a copy of AdminHomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetDoctorsStateSuccessImplCopyWith<_$GetDoctorsStateSuccessImpl>
  get copyWith =>
      __$$GetDoctorsStateSuccessImplCopyWithImpl<_$GetDoctorsStateSuccessImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() homeStateInitial,
    required TResult Function() getDoctorsStateLoading,
    required TResult Function(List<DoctorModel> doctors) getDoctorsStateSuccess,
    required TResult Function(String message) getDoctorsStateError,
    required TResult Function() getPatientsStateLoading,
    required TResult Function(List<PatientModel> patients)
    getPatientsStateSuccess,
    required TResult Function(String message) getPatientsStateError,
  }) {
    return getDoctorsStateSuccess(doctors);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? homeStateInitial,
    TResult? Function()? getDoctorsStateLoading,
    TResult? Function(List<DoctorModel> doctors)? getDoctorsStateSuccess,
    TResult? Function(String message)? getDoctorsStateError,
    TResult? Function()? getPatientsStateLoading,
    TResult? Function(List<PatientModel> patients)? getPatientsStateSuccess,
    TResult? Function(String message)? getPatientsStateError,
  }) {
    return getDoctorsStateSuccess?.call(doctors);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? homeStateInitial,
    TResult Function()? getDoctorsStateLoading,
    TResult Function(List<DoctorModel> doctors)? getDoctorsStateSuccess,
    TResult Function(String message)? getDoctorsStateError,
    TResult Function()? getPatientsStateLoading,
    TResult Function(List<PatientModel> patients)? getPatientsStateSuccess,
    TResult Function(String message)? getPatientsStateError,
    required TResult orElse(),
  }) {
    if (getDoctorsStateSuccess != null) {
      return getDoctorsStateSuccess(doctors);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_HomeStateInitial value) homeStateInitial,
    required TResult Function(GetDoctorsStateLoading value)
    getDoctorsStateLoading,
    required TResult Function(GetDoctorsStateSuccess value)
    getDoctorsStateSuccess,
    required TResult Function(GetDoctorsStateError value) getDoctorsStateError,
    required TResult Function(GetPatientsStateLoading value)
    getPatientsStateLoading,
    required TResult Function(GetPatientsStateSuccess value)
    getPatientsStateSuccess,
    required TResult Function(GetPatientsStateError value)
    getPatientsStateError,
  }) {
    return getDoctorsStateSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_HomeStateInitial value)? homeStateInitial,
    TResult? Function(GetDoctorsStateLoading value)? getDoctorsStateLoading,
    TResult? Function(GetDoctorsStateSuccess value)? getDoctorsStateSuccess,
    TResult? Function(GetDoctorsStateError value)? getDoctorsStateError,
    TResult? Function(GetPatientsStateLoading value)? getPatientsStateLoading,
    TResult? Function(GetPatientsStateSuccess value)? getPatientsStateSuccess,
    TResult? Function(GetPatientsStateError value)? getPatientsStateError,
  }) {
    return getDoctorsStateSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_HomeStateInitial value)? homeStateInitial,
    TResult Function(GetDoctorsStateLoading value)? getDoctorsStateLoading,
    TResult Function(GetDoctorsStateSuccess value)? getDoctorsStateSuccess,
    TResult Function(GetDoctorsStateError value)? getDoctorsStateError,
    TResult Function(GetPatientsStateLoading value)? getPatientsStateLoading,
    TResult Function(GetPatientsStateSuccess value)? getPatientsStateSuccess,
    TResult Function(GetPatientsStateError value)? getPatientsStateError,
    required TResult orElse(),
  }) {
    if (getDoctorsStateSuccess != null) {
      return getDoctorsStateSuccess(this);
    }
    return orElse();
  }
}

abstract class GetDoctorsStateSuccess implements AdminHomeState {
  const factory GetDoctorsStateSuccess(final List<DoctorModel> doctors) =
      _$GetDoctorsStateSuccessImpl;

  List<DoctorModel> get doctors;

  /// Create a copy of AdminHomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetDoctorsStateSuccessImplCopyWith<_$GetDoctorsStateSuccessImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetDoctorsStateErrorImplCopyWith<$Res> {
  factory _$$GetDoctorsStateErrorImplCopyWith(
    _$GetDoctorsStateErrorImpl value,
    $Res Function(_$GetDoctorsStateErrorImpl) then,
  ) = __$$GetDoctorsStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$GetDoctorsStateErrorImplCopyWithImpl<$Res>
    extends _$AdminHomeStateCopyWithImpl<$Res, _$GetDoctorsStateErrorImpl>
    implements _$$GetDoctorsStateErrorImplCopyWith<$Res> {
  __$$GetDoctorsStateErrorImplCopyWithImpl(
    _$GetDoctorsStateErrorImpl _value,
    $Res Function(_$GetDoctorsStateErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminHomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$GetDoctorsStateErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class _$GetDoctorsStateErrorImpl implements GetDoctorsStateError {
  const _$GetDoctorsStateErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'AdminHomeState.getDoctorsStateError(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetDoctorsStateErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AdminHomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetDoctorsStateErrorImplCopyWith<_$GetDoctorsStateErrorImpl>
  get copyWith =>
      __$$GetDoctorsStateErrorImplCopyWithImpl<_$GetDoctorsStateErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() homeStateInitial,
    required TResult Function() getDoctorsStateLoading,
    required TResult Function(List<DoctorModel> doctors) getDoctorsStateSuccess,
    required TResult Function(String message) getDoctorsStateError,
    required TResult Function() getPatientsStateLoading,
    required TResult Function(List<PatientModel> patients)
    getPatientsStateSuccess,
    required TResult Function(String message) getPatientsStateError,
  }) {
    return getDoctorsStateError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? homeStateInitial,
    TResult? Function()? getDoctorsStateLoading,
    TResult? Function(List<DoctorModel> doctors)? getDoctorsStateSuccess,
    TResult? Function(String message)? getDoctorsStateError,
    TResult? Function()? getPatientsStateLoading,
    TResult? Function(List<PatientModel> patients)? getPatientsStateSuccess,
    TResult? Function(String message)? getPatientsStateError,
  }) {
    return getDoctorsStateError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? homeStateInitial,
    TResult Function()? getDoctorsStateLoading,
    TResult Function(List<DoctorModel> doctors)? getDoctorsStateSuccess,
    TResult Function(String message)? getDoctorsStateError,
    TResult Function()? getPatientsStateLoading,
    TResult Function(List<PatientModel> patients)? getPatientsStateSuccess,
    TResult Function(String message)? getPatientsStateError,
    required TResult orElse(),
  }) {
    if (getDoctorsStateError != null) {
      return getDoctorsStateError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_HomeStateInitial value) homeStateInitial,
    required TResult Function(GetDoctorsStateLoading value)
    getDoctorsStateLoading,
    required TResult Function(GetDoctorsStateSuccess value)
    getDoctorsStateSuccess,
    required TResult Function(GetDoctorsStateError value) getDoctorsStateError,
    required TResult Function(GetPatientsStateLoading value)
    getPatientsStateLoading,
    required TResult Function(GetPatientsStateSuccess value)
    getPatientsStateSuccess,
    required TResult Function(GetPatientsStateError value)
    getPatientsStateError,
  }) {
    return getDoctorsStateError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_HomeStateInitial value)? homeStateInitial,
    TResult? Function(GetDoctorsStateLoading value)? getDoctorsStateLoading,
    TResult? Function(GetDoctorsStateSuccess value)? getDoctorsStateSuccess,
    TResult? Function(GetDoctorsStateError value)? getDoctorsStateError,
    TResult? Function(GetPatientsStateLoading value)? getPatientsStateLoading,
    TResult? Function(GetPatientsStateSuccess value)? getPatientsStateSuccess,
    TResult? Function(GetPatientsStateError value)? getPatientsStateError,
  }) {
    return getDoctorsStateError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_HomeStateInitial value)? homeStateInitial,
    TResult Function(GetDoctorsStateLoading value)? getDoctorsStateLoading,
    TResult Function(GetDoctorsStateSuccess value)? getDoctorsStateSuccess,
    TResult Function(GetDoctorsStateError value)? getDoctorsStateError,
    TResult Function(GetPatientsStateLoading value)? getPatientsStateLoading,
    TResult Function(GetPatientsStateSuccess value)? getPatientsStateSuccess,
    TResult Function(GetPatientsStateError value)? getPatientsStateError,
    required TResult orElse(),
  }) {
    if (getDoctorsStateError != null) {
      return getDoctorsStateError(this);
    }
    return orElse();
  }
}

abstract class GetDoctorsStateError implements AdminHomeState {
  const factory GetDoctorsStateError(final String message) =
      _$GetDoctorsStateErrorImpl;

  String get message;

  /// Create a copy of AdminHomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetDoctorsStateErrorImplCopyWith<_$GetDoctorsStateErrorImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetPatientsStateLoadingImplCopyWith<$Res> {
  factory _$$GetPatientsStateLoadingImplCopyWith(
    _$GetPatientsStateLoadingImpl value,
    $Res Function(_$GetPatientsStateLoadingImpl) then,
  ) = __$$GetPatientsStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GetPatientsStateLoadingImplCopyWithImpl<$Res>
    extends _$AdminHomeStateCopyWithImpl<$Res, _$GetPatientsStateLoadingImpl>
    implements _$$GetPatientsStateLoadingImplCopyWith<$Res> {
  __$$GetPatientsStateLoadingImplCopyWithImpl(
    _$GetPatientsStateLoadingImpl _value,
    $Res Function(_$GetPatientsStateLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminHomeState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$GetPatientsStateLoadingImpl implements GetPatientsStateLoading {
  const _$GetPatientsStateLoadingImpl();

  @override
  String toString() {
    return 'AdminHomeState.getPatientsStateLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetPatientsStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() homeStateInitial,
    required TResult Function() getDoctorsStateLoading,
    required TResult Function(List<DoctorModel> doctors) getDoctorsStateSuccess,
    required TResult Function(String message) getDoctorsStateError,
    required TResult Function() getPatientsStateLoading,
    required TResult Function(List<PatientModel> patients)
    getPatientsStateSuccess,
    required TResult Function(String message) getPatientsStateError,
  }) {
    return getPatientsStateLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? homeStateInitial,
    TResult? Function()? getDoctorsStateLoading,
    TResult? Function(List<DoctorModel> doctors)? getDoctorsStateSuccess,
    TResult? Function(String message)? getDoctorsStateError,
    TResult? Function()? getPatientsStateLoading,
    TResult? Function(List<PatientModel> patients)? getPatientsStateSuccess,
    TResult? Function(String message)? getPatientsStateError,
  }) {
    return getPatientsStateLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? homeStateInitial,
    TResult Function()? getDoctorsStateLoading,
    TResult Function(List<DoctorModel> doctors)? getDoctorsStateSuccess,
    TResult Function(String message)? getDoctorsStateError,
    TResult Function()? getPatientsStateLoading,
    TResult Function(List<PatientModel> patients)? getPatientsStateSuccess,
    TResult Function(String message)? getPatientsStateError,
    required TResult orElse(),
  }) {
    if (getPatientsStateLoading != null) {
      return getPatientsStateLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_HomeStateInitial value) homeStateInitial,
    required TResult Function(GetDoctorsStateLoading value)
    getDoctorsStateLoading,
    required TResult Function(GetDoctorsStateSuccess value)
    getDoctorsStateSuccess,
    required TResult Function(GetDoctorsStateError value) getDoctorsStateError,
    required TResult Function(GetPatientsStateLoading value)
    getPatientsStateLoading,
    required TResult Function(GetPatientsStateSuccess value)
    getPatientsStateSuccess,
    required TResult Function(GetPatientsStateError value)
    getPatientsStateError,
  }) {
    return getPatientsStateLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_HomeStateInitial value)? homeStateInitial,
    TResult? Function(GetDoctorsStateLoading value)? getDoctorsStateLoading,
    TResult? Function(GetDoctorsStateSuccess value)? getDoctorsStateSuccess,
    TResult? Function(GetDoctorsStateError value)? getDoctorsStateError,
    TResult? Function(GetPatientsStateLoading value)? getPatientsStateLoading,
    TResult? Function(GetPatientsStateSuccess value)? getPatientsStateSuccess,
    TResult? Function(GetPatientsStateError value)? getPatientsStateError,
  }) {
    return getPatientsStateLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_HomeStateInitial value)? homeStateInitial,
    TResult Function(GetDoctorsStateLoading value)? getDoctorsStateLoading,
    TResult Function(GetDoctorsStateSuccess value)? getDoctorsStateSuccess,
    TResult Function(GetDoctorsStateError value)? getDoctorsStateError,
    TResult Function(GetPatientsStateLoading value)? getPatientsStateLoading,
    TResult Function(GetPatientsStateSuccess value)? getPatientsStateSuccess,
    TResult Function(GetPatientsStateError value)? getPatientsStateError,
    required TResult orElse(),
  }) {
    if (getPatientsStateLoading != null) {
      return getPatientsStateLoading(this);
    }
    return orElse();
  }
}

abstract class GetPatientsStateLoading implements AdminHomeState {
  const factory GetPatientsStateLoading() = _$GetPatientsStateLoadingImpl;
}

/// @nodoc
abstract class _$$GetPatientsStateSuccessImplCopyWith<$Res> {
  factory _$$GetPatientsStateSuccessImplCopyWith(
    _$GetPatientsStateSuccessImpl value,
    $Res Function(_$GetPatientsStateSuccessImpl) then,
  ) = __$$GetPatientsStateSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<PatientModel> patients});
}

/// @nodoc
class __$$GetPatientsStateSuccessImplCopyWithImpl<$Res>
    extends _$AdminHomeStateCopyWithImpl<$Res, _$GetPatientsStateSuccessImpl>
    implements _$$GetPatientsStateSuccessImplCopyWith<$Res> {
  __$$GetPatientsStateSuccessImplCopyWithImpl(
    _$GetPatientsStateSuccessImpl _value,
    $Res Function(_$GetPatientsStateSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminHomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? patients = null}) {
    return _then(
      _$GetPatientsStateSuccessImpl(
        null == patients
            ? _value._patients
            : patients // ignore: cast_nullable_to_non_nullable
                as List<PatientModel>,
      ),
    );
  }
}

/// @nodoc

class _$GetPatientsStateSuccessImpl implements GetPatientsStateSuccess {
  const _$GetPatientsStateSuccessImpl(final List<PatientModel> patients)
    : _patients = patients;

  final List<PatientModel> _patients;
  @override
  List<PatientModel> get patients {
    if (_patients is EqualUnmodifiableListView) return _patients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_patients);
  }

  @override
  String toString() {
    return 'AdminHomeState.getPatientsStateSuccess(patients: $patients)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetPatientsStateSuccessImpl &&
            const DeepCollectionEquality().equals(other._patients, _patients));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_patients));

  /// Create a copy of AdminHomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetPatientsStateSuccessImplCopyWith<_$GetPatientsStateSuccessImpl>
  get copyWith => __$$GetPatientsStateSuccessImplCopyWithImpl<
    _$GetPatientsStateSuccessImpl
  >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() homeStateInitial,
    required TResult Function() getDoctorsStateLoading,
    required TResult Function(List<DoctorModel> doctors) getDoctorsStateSuccess,
    required TResult Function(String message) getDoctorsStateError,
    required TResult Function() getPatientsStateLoading,
    required TResult Function(List<PatientModel> patients)
    getPatientsStateSuccess,
    required TResult Function(String message) getPatientsStateError,
  }) {
    return getPatientsStateSuccess(patients);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? homeStateInitial,
    TResult? Function()? getDoctorsStateLoading,
    TResult? Function(List<DoctorModel> doctors)? getDoctorsStateSuccess,
    TResult? Function(String message)? getDoctorsStateError,
    TResult? Function()? getPatientsStateLoading,
    TResult? Function(List<PatientModel> patients)? getPatientsStateSuccess,
    TResult? Function(String message)? getPatientsStateError,
  }) {
    return getPatientsStateSuccess?.call(patients);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? homeStateInitial,
    TResult Function()? getDoctorsStateLoading,
    TResult Function(List<DoctorModel> doctors)? getDoctorsStateSuccess,
    TResult Function(String message)? getDoctorsStateError,
    TResult Function()? getPatientsStateLoading,
    TResult Function(List<PatientModel> patients)? getPatientsStateSuccess,
    TResult Function(String message)? getPatientsStateError,
    required TResult orElse(),
  }) {
    if (getPatientsStateSuccess != null) {
      return getPatientsStateSuccess(patients);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_HomeStateInitial value) homeStateInitial,
    required TResult Function(GetDoctorsStateLoading value)
    getDoctorsStateLoading,
    required TResult Function(GetDoctorsStateSuccess value)
    getDoctorsStateSuccess,
    required TResult Function(GetDoctorsStateError value) getDoctorsStateError,
    required TResult Function(GetPatientsStateLoading value)
    getPatientsStateLoading,
    required TResult Function(GetPatientsStateSuccess value)
    getPatientsStateSuccess,
    required TResult Function(GetPatientsStateError value)
    getPatientsStateError,
  }) {
    return getPatientsStateSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_HomeStateInitial value)? homeStateInitial,
    TResult? Function(GetDoctorsStateLoading value)? getDoctorsStateLoading,
    TResult? Function(GetDoctorsStateSuccess value)? getDoctorsStateSuccess,
    TResult? Function(GetDoctorsStateError value)? getDoctorsStateError,
    TResult? Function(GetPatientsStateLoading value)? getPatientsStateLoading,
    TResult? Function(GetPatientsStateSuccess value)? getPatientsStateSuccess,
    TResult? Function(GetPatientsStateError value)? getPatientsStateError,
  }) {
    return getPatientsStateSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_HomeStateInitial value)? homeStateInitial,
    TResult Function(GetDoctorsStateLoading value)? getDoctorsStateLoading,
    TResult Function(GetDoctorsStateSuccess value)? getDoctorsStateSuccess,
    TResult Function(GetDoctorsStateError value)? getDoctorsStateError,
    TResult Function(GetPatientsStateLoading value)? getPatientsStateLoading,
    TResult Function(GetPatientsStateSuccess value)? getPatientsStateSuccess,
    TResult Function(GetPatientsStateError value)? getPatientsStateError,
    required TResult orElse(),
  }) {
    if (getPatientsStateSuccess != null) {
      return getPatientsStateSuccess(this);
    }
    return orElse();
  }
}

abstract class GetPatientsStateSuccess implements AdminHomeState {
  const factory GetPatientsStateSuccess(final List<PatientModel> patients) =
      _$GetPatientsStateSuccessImpl;

  List<PatientModel> get patients;

  /// Create a copy of AdminHomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetPatientsStateSuccessImplCopyWith<_$GetPatientsStateSuccessImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetPatientsStateErrorImplCopyWith<$Res> {
  factory _$$GetPatientsStateErrorImplCopyWith(
    _$GetPatientsStateErrorImpl value,
    $Res Function(_$GetPatientsStateErrorImpl) then,
  ) = __$$GetPatientsStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$GetPatientsStateErrorImplCopyWithImpl<$Res>
    extends _$AdminHomeStateCopyWithImpl<$Res, _$GetPatientsStateErrorImpl>
    implements _$$GetPatientsStateErrorImplCopyWith<$Res> {
  __$$GetPatientsStateErrorImplCopyWithImpl(
    _$GetPatientsStateErrorImpl _value,
    $Res Function(_$GetPatientsStateErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminHomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$GetPatientsStateErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class _$GetPatientsStateErrorImpl implements GetPatientsStateError {
  const _$GetPatientsStateErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'AdminHomeState.getPatientsStateError(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetPatientsStateErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AdminHomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetPatientsStateErrorImplCopyWith<_$GetPatientsStateErrorImpl>
  get copyWith =>
      __$$GetPatientsStateErrorImplCopyWithImpl<_$GetPatientsStateErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() homeStateInitial,
    required TResult Function() getDoctorsStateLoading,
    required TResult Function(List<DoctorModel> doctors) getDoctorsStateSuccess,
    required TResult Function(String message) getDoctorsStateError,
    required TResult Function() getPatientsStateLoading,
    required TResult Function(List<PatientModel> patients)
    getPatientsStateSuccess,
    required TResult Function(String message) getPatientsStateError,
  }) {
    return getPatientsStateError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? homeStateInitial,
    TResult? Function()? getDoctorsStateLoading,
    TResult? Function(List<DoctorModel> doctors)? getDoctorsStateSuccess,
    TResult? Function(String message)? getDoctorsStateError,
    TResult? Function()? getPatientsStateLoading,
    TResult? Function(List<PatientModel> patients)? getPatientsStateSuccess,
    TResult? Function(String message)? getPatientsStateError,
  }) {
    return getPatientsStateError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? homeStateInitial,
    TResult Function()? getDoctorsStateLoading,
    TResult Function(List<DoctorModel> doctors)? getDoctorsStateSuccess,
    TResult Function(String message)? getDoctorsStateError,
    TResult Function()? getPatientsStateLoading,
    TResult Function(List<PatientModel> patients)? getPatientsStateSuccess,
    TResult Function(String message)? getPatientsStateError,
    required TResult orElse(),
  }) {
    if (getPatientsStateError != null) {
      return getPatientsStateError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_HomeStateInitial value) homeStateInitial,
    required TResult Function(GetDoctorsStateLoading value)
    getDoctorsStateLoading,
    required TResult Function(GetDoctorsStateSuccess value)
    getDoctorsStateSuccess,
    required TResult Function(GetDoctorsStateError value) getDoctorsStateError,
    required TResult Function(GetPatientsStateLoading value)
    getPatientsStateLoading,
    required TResult Function(GetPatientsStateSuccess value)
    getPatientsStateSuccess,
    required TResult Function(GetPatientsStateError value)
    getPatientsStateError,
  }) {
    return getPatientsStateError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_HomeStateInitial value)? homeStateInitial,
    TResult? Function(GetDoctorsStateLoading value)? getDoctorsStateLoading,
    TResult? Function(GetDoctorsStateSuccess value)? getDoctorsStateSuccess,
    TResult? Function(GetDoctorsStateError value)? getDoctorsStateError,
    TResult? Function(GetPatientsStateLoading value)? getPatientsStateLoading,
    TResult? Function(GetPatientsStateSuccess value)? getPatientsStateSuccess,
    TResult? Function(GetPatientsStateError value)? getPatientsStateError,
  }) {
    return getPatientsStateError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_HomeStateInitial value)? homeStateInitial,
    TResult Function(GetDoctorsStateLoading value)? getDoctorsStateLoading,
    TResult Function(GetDoctorsStateSuccess value)? getDoctorsStateSuccess,
    TResult Function(GetDoctorsStateError value)? getDoctorsStateError,
    TResult Function(GetPatientsStateLoading value)? getPatientsStateLoading,
    TResult Function(GetPatientsStateSuccess value)? getPatientsStateSuccess,
    TResult Function(GetPatientsStateError value)? getPatientsStateError,
    required TResult orElse(),
  }) {
    if (getPatientsStateError != null) {
      return getPatientsStateError(this);
    }
    return orElse();
  }
}

abstract class GetPatientsStateError implements AdminHomeState {
  const factory GetPatientsStateError(final String message) =
      _$GetPatientsStateErrorImpl;

  String get message;

  /// Create a copy of AdminHomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetPatientsStateErrorImplCopyWith<_$GetPatientsStateErrorImpl>
  get copyWith => throw _privateConstructorUsedError;
}
