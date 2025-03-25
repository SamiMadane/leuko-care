// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_login_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AdminLoginState<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() adminLoginLoading,
    required TResult Function(User user) adminLoginSuccess,
    required TResult Function(String error) adminLoginError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? adminLoginLoading,
    TResult? Function(User user)? adminLoginSuccess,
    TResult? Function(String error)? adminLoginError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? adminLoginLoading,
    TResult Function(User user)? adminLoginSuccess,
    TResult Function(String error)? adminLoginError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AdminLoginInitial<T> value) initial,
    required TResult Function(AdminLoginLoading<T> value) adminLoginLoading,
    required TResult Function(AdminLoginSuccess<T> value) adminLoginSuccess,
    required TResult Function(AdminLoginError<T> value) adminLoginError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AdminLoginInitial<T> value)? initial,
    TResult? Function(AdminLoginLoading<T> value)? adminLoginLoading,
    TResult? Function(AdminLoginSuccess<T> value)? adminLoginSuccess,
    TResult? Function(AdminLoginError<T> value)? adminLoginError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AdminLoginInitial<T> value)? initial,
    TResult Function(AdminLoginLoading<T> value)? adminLoginLoading,
    TResult Function(AdminLoginSuccess<T> value)? adminLoginSuccess,
    TResult Function(AdminLoginError<T> value)? adminLoginError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminLoginStateCopyWith<T, $Res> {
  factory $AdminLoginStateCopyWith(
    AdminLoginState<T> value,
    $Res Function(AdminLoginState<T>) then,
  ) = _$AdminLoginStateCopyWithImpl<T, $Res, AdminLoginState<T>>;
}

/// @nodoc
class _$AdminLoginStateCopyWithImpl<T, $Res, $Val extends AdminLoginState<T>>
    implements $AdminLoginStateCopyWith<T, $Res> {
  _$AdminLoginStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminLoginState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AdminLoginInitialImplCopyWith<T, $Res> {
  factory _$$AdminLoginInitialImplCopyWith(
    _$AdminLoginInitialImpl<T> value,
    $Res Function(_$AdminLoginInitialImpl<T>) then,
  ) = __$$AdminLoginInitialImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$AdminLoginInitialImplCopyWithImpl<T, $Res>
    extends _$AdminLoginStateCopyWithImpl<T, $Res, _$AdminLoginInitialImpl<T>>
    implements _$$AdminLoginInitialImplCopyWith<T, $Res> {
  __$$AdminLoginInitialImplCopyWithImpl(
    _$AdminLoginInitialImpl<T> _value,
    $Res Function(_$AdminLoginInitialImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminLoginState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AdminLoginInitialImpl<T> implements _AdminLoginInitial<T> {
  const _$AdminLoginInitialImpl();

  @override
  String toString() {
    return 'AdminLoginState<$T>.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminLoginInitialImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() adminLoginLoading,
    required TResult Function(User user) adminLoginSuccess,
    required TResult Function(String error) adminLoginError,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? adminLoginLoading,
    TResult? Function(User user)? adminLoginSuccess,
    TResult? Function(String error)? adminLoginError,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? adminLoginLoading,
    TResult Function(User user)? adminLoginSuccess,
    TResult Function(String error)? adminLoginError,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AdminLoginInitial<T> value) initial,
    required TResult Function(AdminLoginLoading<T> value) adminLoginLoading,
    required TResult Function(AdminLoginSuccess<T> value) adminLoginSuccess,
    required TResult Function(AdminLoginError<T> value) adminLoginError,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AdminLoginInitial<T> value)? initial,
    TResult? Function(AdminLoginLoading<T> value)? adminLoginLoading,
    TResult? Function(AdminLoginSuccess<T> value)? adminLoginSuccess,
    TResult? Function(AdminLoginError<T> value)? adminLoginError,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AdminLoginInitial<T> value)? initial,
    TResult Function(AdminLoginLoading<T> value)? adminLoginLoading,
    TResult Function(AdminLoginSuccess<T> value)? adminLoginSuccess,
    TResult Function(AdminLoginError<T> value)? adminLoginError,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _AdminLoginInitial<T> implements AdminLoginState<T> {
  const factory _AdminLoginInitial() = _$AdminLoginInitialImpl<T>;
}

/// @nodoc
abstract class _$$AdminLoginLoadingImplCopyWith<T, $Res> {
  factory _$$AdminLoginLoadingImplCopyWith(
    _$AdminLoginLoadingImpl<T> value,
    $Res Function(_$AdminLoginLoadingImpl<T>) then,
  ) = __$$AdminLoginLoadingImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$AdminLoginLoadingImplCopyWithImpl<T, $Res>
    extends _$AdminLoginStateCopyWithImpl<T, $Res, _$AdminLoginLoadingImpl<T>>
    implements _$$AdminLoginLoadingImplCopyWith<T, $Res> {
  __$$AdminLoginLoadingImplCopyWithImpl(
    _$AdminLoginLoadingImpl<T> _value,
    $Res Function(_$AdminLoginLoadingImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminLoginState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AdminLoginLoadingImpl<T> implements AdminLoginLoading<T> {
  const _$AdminLoginLoadingImpl();

  @override
  String toString() {
    return 'AdminLoginState<$T>.adminLoginLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminLoginLoadingImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() adminLoginLoading,
    required TResult Function(User user) adminLoginSuccess,
    required TResult Function(String error) adminLoginError,
  }) {
    return adminLoginLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? adminLoginLoading,
    TResult? Function(User user)? adminLoginSuccess,
    TResult? Function(String error)? adminLoginError,
  }) {
    return adminLoginLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? adminLoginLoading,
    TResult Function(User user)? adminLoginSuccess,
    TResult Function(String error)? adminLoginError,
    required TResult orElse(),
  }) {
    if (adminLoginLoading != null) {
      return adminLoginLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AdminLoginInitial<T> value) initial,
    required TResult Function(AdminLoginLoading<T> value) adminLoginLoading,
    required TResult Function(AdminLoginSuccess<T> value) adminLoginSuccess,
    required TResult Function(AdminLoginError<T> value) adminLoginError,
  }) {
    return adminLoginLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AdminLoginInitial<T> value)? initial,
    TResult? Function(AdminLoginLoading<T> value)? adminLoginLoading,
    TResult? Function(AdminLoginSuccess<T> value)? adminLoginSuccess,
    TResult? Function(AdminLoginError<T> value)? adminLoginError,
  }) {
    return adminLoginLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AdminLoginInitial<T> value)? initial,
    TResult Function(AdminLoginLoading<T> value)? adminLoginLoading,
    TResult Function(AdminLoginSuccess<T> value)? adminLoginSuccess,
    TResult Function(AdminLoginError<T> value)? adminLoginError,
    required TResult orElse(),
  }) {
    if (adminLoginLoading != null) {
      return adminLoginLoading(this);
    }
    return orElse();
  }
}

abstract class AdminLoginLoading<T> implements AdminLoginState<T> {
  const factory AdminLoginLoading() = _$AdminLoginLoadingImpl<T>;
}

/// @nodoc
abstract class _$$AdminLoginSuccessImplCopyWith<T, $Res> {
  factory _$$AdminLoginSuccessImplCopyWith(
    _$AdminLoginSuccessImpl<T> value,
    $Res Function(_$AdminLoginSuccessImpl<T>) then,
  ) = __$$AdminLoginSuccessImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({User user});
}

/// @nodoc
class __$$AdminLoginSuccessImplCopyWithImpl<T, $Res>
    extends _$AdminLoginStateCopyWithImpl<T, $Res, _$AdminLoginSuccessImpl<T>>
    implements _$$AdminLoginSuccessImplCopyWith<T, $Res> {
  __$$AdminLoginSuccessImplCopyWithImpl(
    _$AdminLoginSuccessImpl<T> _value,
    $Res Function(_$AdminLoginSuccessImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminLoginState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? user = null}) {
    return _then(
      _$AdminLoginSuccessImpl<T>(
        null == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                as User,
      ),
    );
  }
}

/// @nodoc

class _$AdminLoginSuccessImpl<T> implements AdminLoginSuccess<T> {
  const _$AdminLoginSuccessImpl(this.user);

  @override
  final User user;

  @override
  String toString() {
    return 'AdminLoginState<$T>.adminLoginSuccess(user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminLoginSuccessImpl<T> &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  /// Create a copy of AdminLoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminLoginSuccessImplCopyWith<T, _$AdminLoginSuccessImpl<T>>
  get copyWith =>
      __$$AdminLoginSuccessImplCopyWithImpl<T, _$AdminLoginSuccessImpl<T>>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() adminLoginLoading,
    required TResult Function(User user) adminLoginSuccess,
    required TResult Function(String error) adminLoginError,
  }) {
    return adminLoginSuccess(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? adminLoginLoading,
    TResult? Function(User user)? adminLoginSuccess,
    TResult? Function(String error)? adminLoginError,
  }) {
    return adminLoginSuccess?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? adminLoginLoading,
    TResult Function(User user)? adminLoginSuccess,
    TResult Function(String error)? adminLoginError,
    required TResult orElse(),
  }) {
    if (adminLoginSuccess != null) {
      return adminLoginSuccess(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AdminLoginInitial<T> value) initial,
    required TResult Function(AdminLoginLoading<T> value) adminLoginLoading,
    required TResult Function(AdminLoginSuccess<T> value) adminLoginSuccess,
    required TResult Function(AdminLoginError<T> value) adminLoginError,
  }) {
    return adminLoginSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AdminLoginInitial<T> value)? initial,
    TResult? Function(AdminLoginLoading<T> value)? adminLoginLoading,
    TResult? Function(AdminLoginSuccess<T> value)? adminLoginSuccess,
    TResult? Function(AdminLoginError<T> value)? adminLoginError,
  }) {
    return adminLoginSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AdminLoginInitial<T> value)? initial,
    TResult Function(AdminLoginLoading<T> value)? adminLoginLoading,
    TResult Function(AdminLoginSuccess<T> value)? adminLoginSuccess,
    TResult Function(AdminLoginError<T> value)? adminLoginError,
    required TResult orElse(),
  }) {
    if (adminLoginSuccess != null) {
      return adminLoginSuccess(this);
    }
    return orElse();
  }
}

abstract class AdminLoginSuccess<T> implements AdminLoginState<T> {
  const factory AdminLoginSuccess(final User user) = _$AdminLoginSuccessImpl<T>;

  User get user;

  /// Create a copy of AdminLoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminLoginSuccessImplCopyWith<T, _$AdminLoginSuccessImpl<T>>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AdminLoginErrorImplCopyWith<T, $Res> {
  factory _$$AdminLoginErrorImplCopyWith(
    _$AdminLoginErrorImpl<T> value,
    $Res Function(_$AdminLoginErrorImpl<T>) then,
  ) = __$$AdminLoginErrorImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$AdminLoginErrorImplCopyWithImpl<T, $Res>
    extends _$AdminLoginStateCopyWithImpl<T, $Res, _$AdminLoginErrorImpl<T>>
    implements _$$AdminLoginErrorImplCopyWith<T, $Res> {
  __$$AdminLoginErrorImplCopyWithImpl(
    _$AdminLoginErrorImpl<T> _value,
    $Res Function(_$AdminLoginErrorImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminLoginState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? error = null}) {
    return _then(
      _$AdminLoginErrorImpl<T>(
        null == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class _$AdminLoginErrorImpl<T> implements AdminLoginError<T> {
  const _$AdminLoginErrorImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'AdminLoginState<$T>.adminLoginError(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminLoginErrorImpl<T> &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of AdminLoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminLoginErrorImplCopyWith<T, _$AdminLoginErrorImpl<T>> get copyWith =>
      __$$AdminLoginErrorImplCopyWithImpl<T, _$AdminLoginErrorImpl<T>>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() adminLoginLoading,
    required TResult Function(User user) adminLoginSuccess,
    required TResult Function(String error) adminLoginError,
  }) {
    return adminLoginError(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? adminLoginLoading,
    TResult? Function(User user)? adminLoginSuccess,
    TResult? Function(String error)? adminLoginError,
  }) {
    return adminLoginError?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? adminLoginLoading,
    TResult Function(User user)? adminLoginSuccess,
    TResult Function(String error)? adminLoginError,
    required TResult orElse(),
  }) {
    if (adminLoginError != null) {
      return adminLoginError(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AdminLoginInitial<T> value) initial,
    required TResult Function(AdminLoginLoading<T> value) adminLoginLoading,
    required TResult Function(AdminLoginSuccess<T> value) adminLoginSuccess,
    required TResult Function(AdminLoginError<T> value) adminLoginError,
  }) {
    return adminLoginError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AdminLoginInitial<T> value)? initial,
    TResult? Function(AdminLoginLoading<T> value)? adminLoginLoading,
    TResult? Function(AdminLoginSuccess<T> value)? adminLoginSuccess,
    TResult? Function(AdminLoginError<T> value)? adminLoginError,
  }) {
    return adminLoginError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AdminLoginInitial<T> value)? initial,
    TResult Function(AdminLoginLoading<T> value)? adminLoginLoading,
    TResult Function(AdminLoginSuccess<T> value)? adminLoginSuccess,
    TResult Function(AdminLoginError<T> value)? adminLoginError,
    required TResult orElse(),
  }) {
    if (adminLoginError != null) {
      return adminLoginError(this);
    }
    return orElse();
  }
}

abstract class AdminLoginError<T> implements AdminLoginState<T> {
  const factory AdminLoginError(final String error) = _$AdminLoginErrorImpl<T>;

  String get error;

  /// Create a copy of AdminLoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminLoginErrorImplCopyWith<T, _$AdminLoginErrorImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
