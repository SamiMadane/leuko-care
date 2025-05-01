// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AuthState<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loginLoading,
    required TResult Function(User user, String userType) loginSuccess,
    required TResult Function(String error) loginError,
    required TResult Function() signedOutStateLoading,
    required TResult Function() signedOutStateSuccess,
    required TResult Function(String message) signedOutStateError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loginLoading,
    TResult? Function(User user, String userType)? loginSuccess,
    TResult? Function(String error)? loginError,
    TResult? Function()? signedOutStateLoading,
    TResult? Function()? signedOutStateSuccess,
    TResult? Function(String message)? signedOutStateError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loginLoading,
    TResult Function(User user, String userType)? loginSuccess,
    TResult Function(String error)? loginError,
    TResult Function()? signedOutStateLoading,
    TResult Function()? signedOutStateSuccess,
    TResult Function(String message)? signedOutStateError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginInitial<T> value) initial,
    required TResult Function(LoginLoading<T> value) loginLoading,
    required TResult Function(LoginSuccess<T> value) loginSuccess,
    required TResult Function(LoginError<T> value) loginError,
    required TResult Function(SignedOutStateLoading<T> value)
    signedOutStateLoading,
    required TResult Function(SignedOutStateSuccess<T> value)
    signedOutStateSuccess,
    required TResult Function(SignedOutStateError<T> value) signedOutStateError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginInitial<T> value)? initial,
    TResult? Function(LoginLoading<T> value)? loginLoading,
    TResult? Function(LoginSuccess<T> value)? loginSuccess,
    TResult? Function(LoginError<T> value)? loginError,
    TResult? Function(SignedOutStateLoading<T> value)? signedOutStateLoading,
    TResult? Function(SignedOutStateSuccess<T> value)? signedOutStateSuccess,
    TResult? Function(SignedOutStateError<T> value)? signedOutStateError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginInitial<T> value)? initial,
    TResult Function(LoginLoading<T> value)? loginLoading,
    TResult Function(LoginSuccess<T> value)? loginSuccess,
    TResult Function(LoginError<T> value)? loginError,
    TResult Function(SignedOutStateLoading<T> value)? signedOutStateLoading,
    TResult Function(SignedOutStateSuccess<T> value)? signedOutStateSuccess,
    TResult Function(SignedOutStateError<T> value)? signedOutStateError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<T, $Res> {
  factory $AuthStateCopyWith(
    AuthState<T> value,
    $Res Function(AuthState<T>) then,
  ) = _$AuthStateCopyWithImpl<T, $Res, AuthState<T>>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<T, $Res, $Val extends AuthState<T>>
    implements $AuthStateCopyWith<T, $Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoginInitialImplCopyWith<T, $Res> {
  factory _$$LoginInitialImplCopyWith(
    _$LoginInitialImpl<T> value,
    $Res Function(_$LoginInitialImpl<T>) then,
  ) = __$$LoginInitialImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$LoginInitialImplCopyWithImpl<T, $Res>
    extends _$AuthStateCopyWithImpl<T, $Res, _$LoginInitialImpl<T>>
    implements _$$LoginInitialImplCopyWith<T, $Res> {
  __$$LoginInitialImplCopyWithImpl(
    _$LoginInitialImpl<T> _value,
    $Res Function(_$LoginInitialImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoginInitialImpl<T> implements _LoginInitial<T> {
  const _$LoginInitialImpl();

  @override
  String toString() {
    return 'AuthState<$T>.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoginInitialImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loginLoading,
    required TResult Function(User user, String userType) loginSuccess,
    required TResult Function(String error) loginError,
    required TResult Function() signedOutStateLoading,
    required TResult Function() signedOutStateSuccess,
    required TResult Function(String message) signedOutStateError,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loginLoading,
    TResult? Function(User user, String userType)? loginSuccess,
    TResult? Function(String error)? loginError,
    TResult? Function()? signedOutStateLoading,
    TResult? Function()? signedOutStateSuccess,
    TResult? Function(String message)? signedOutStateError,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loginLoading,
    TResult Function(User user, String userType)? loginSuccess,
    TResult Function(String error)? loginError,
    TResult Function()? signedOutStateLoading,
    TResult Function()? signedOutStateSuccess,
    TResult Function(String message)? signedOutStateError,
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
    required TResult Function(_LoginInitial<T> value) initial,
    required TResult Function(LoginLoading<T> value) loginLoading,
    required TResult Function(LoginSuccess<T> value) loginSuccess,
    required TResult Function(LoginError<T> value) loginError,
    required TResult Function(SignedOutStateLoading<T> value)
    signedOutStateLoading,
    required TResult Function(SignedOutStateSuccess<T> value)
    signedOutStateSuccess,
    required TResult Function(SignedOutStateError<T> value) signedOutStateError,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginInitial<T> value)? initial,
    TResult? Function(LoginLoading<T> value)? loginLoading,
    TResult? Function(LoginSuccess<T> value)? loginSuccess,
    TResult? Function(LoginError<T> value)? loginError,
    TResult? Function(SignedOutStateLoading<T> value)? signedOutStateLoading,
    TResult? Function(SignedOutStateSuccess<T> value)? signedOutStateSuccess,
    TResult? Function(SignedOutStateError<T> value)? signedOutStateError,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginInitial<T> value)? initial,
    TResult Function(LoginLoading<T> value)? loginLoading,
    TResult Function(LoginSuccess<T> value)? loginSuccess,
    TResult Function(LoginError<T> value)? loginError,
    TResult Function(SignedOutStateLoading<T> value)? signedOutStateLoading,
    TResult Function(SignedOutStateSuccess<T> value)? signedOutStateSuccess,
    TResult Function(SignedOutStateError<T> value)? signedOutStateError,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _LoginInitial<T> implements AuthState<T> {
  const factory _LoginInitial() = _$LoginInitialImpl<T>;
}

/// @nodoc
abstract class _$$LoginLoadingImplCopyWith<T, $Res> {
  factory _$$LoginLoadingImplCopyWith(
    _$LoginLoadingImpl<T> value,
    $Res Function(_$LoginLoadingImpl<T>) then,
  ) = __$$LoginLoadingImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$LoginLoadingImplCopyWithImpl<T, $Res>
    extends _$AuthStateCopyWithImpl<T, $Res, _$LoginLoadingImpl<T>>
    implements _$$LoginLoadingImplCopyWith<T, $Res> {
  __$$LoginLoadingImplCopyWithImpl(
    _$LoginLoadingImpl<T> _value,
    $Res Function(_$LoginLoadingImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoginLoadingImpl<T> implements LoginLoading<T> {
  const _$LoginLoadingImpl();

  @override
  String toString() {
    return 'AuthState<$T>.loginLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoginLoadingImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loginLoading,
    required TResult Function(User user, String userType) loginSuccess,
    required TResult Function(String error) loginError,
    required TResult Function() signedOutStateLoading,
    required TResult Function() signedOutStateSuccess,
    required TResult Function(String message) signedOutStateError,
  }) {
    return loginLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loginLoading,
    TResult? Function(User user, String userType)? loginSuccess,
    TResult? Function(String error)? loginError,
    TResult? Function()? signedOutStateLoading,
    TResult? Function()? signedOutStateSuccess,
    TResult? Function(String message)? signedOutStateError,
  }) {
    return loginLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loginLoading,
    TResult Function(User user, String userType)? loginSuccess,
    TResult Function(String error)? loginError,
    TResult Function()? signedOutStateLoading,
    TResult Function()? signedOutStateSuccess,
    TResult Function(String message)? signedOutStateError,
    required TResult orElse(),
  }) {
    if (loginLoading != null) {
      return loginLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginInitial<T> value) initial,
    required TResult Function(LoginLoading<T> value) loginLoading,
    required TResult Function(LoginSuccess<T> value) loginSuccess,
    required TResult Function(LoginError<T> value) loginError,
    required TResult Function(SignedOutStateLoading<T> value)
    signedOutStateLoading,
    required TResult Function(SignedOutStateSuccess<T> value)
    signedOutStateSuccess,
    required TResult Function(SignedOutStateError<T> value) signedOutStateError,
  }) {
    return loginLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginInitial<T> value)? initial,
    TResult? Function(LoginLoading<T> value)? loginLoading,
    TResult? Function(LoginSuccess<T> value)? loginSuccess,
    TResult? Function(LoginError<T> value)? loginError,
    TResult? Function(SignedOutStateLoading<T> value)? signedOutStateLoading,
    TResult? Function(SignedOutStateSuccess<T> value)? signedOutStateSuccess,
    TResult? Function(SignedOutStateError<T> value)? signedOutStateError,
  }) {
    return loginLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginInitial<T> value)? initial,
    TResult Function(LoginLoading<T> value)? loginLoading,
    TResult Function(LoginSuccess<T> value)? loginSuccess,
    TResult Function(LoginError<T> value)? loginError,
    TResult Function(SignedOutStateLoading<T> value)? signedOutStateLoading,
    TResult Function(SignedOutStateSuccess<T> value)? signedOutStateSuccess,
    TResult Function(SignedOutStateError<T> value)? signedOutStateError,
    required TResult orElse(),
  }) {
    if (loginLoading != null) {
      return loginLoading(this);
    }
    return orElse();
  }
}

abstract class LoginLoading<T> implements AuthState<T> {
  const factory LoginLoading() = _$LoginLoadingImpl<T>;
}

/// @nodoc
abstract class _$$LoginSuccessImplCopyWith<T, $Res> {
  factory _$$LoginSuccessImplCopyWith(
    _$LoginSuccessImpl<T> value,
    $Res Function(_$LoginSuccessImpl<T>) then,
  ) = __$$LoginSuccessImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({User user, String userType});
}

/// @nodoc
class __$$LoginSuccessImplCopyWithImpl<T, $Res>
    extends _$AuthStateCopyWithImpl<T, $Res, _$LoginSuccessImpl<T>>
    implements _$$LoginSuccessImplCopyWith<T, $Res> {
  __$$LoginSuccessImplCopyWithImpl(
    _$LoginSuccessImpl<T> _value,
    $Res Function(_$LoginSuccessImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? user = null, Object? userType = null}) {
    return _then(
      _$LoginSuccessImpl<T>(
        null == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                as User,
        null == userType
            ? _value.userType
            : userType // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class _$LoginSuccessImpl<T> implements LoginSuccess<T> {
  const _$LoginSuccessImpl(this.user, this.userType);

  @override
  final User user;
  @override
  final String userType;

  @override
  String toString() {
    return 'AuthState<$T>.loginSuccess(user: $user, userType: $userType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginSuccessImpl<T> &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.userType, userType) ||
                other.userType == userType));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user, userType);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginSuccessImplCopyWith<T, _$LoginSuccessImpl<T>> get copyWith =>
      __$$LoginSuccessImplCopyWithImpl<T, _$LoginSuccessImpl<T>>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loginLoading,
    required TResult Function(User user, String userType) loginSuccess,
    required TResult Function(String error) loginError,
    required TResult Function() signedOutStateLoading,
    required TResult Function() signedOutStateSuccess,
    required TResult Function(String message) signedOutStateError,
  }) {
    return loginSuccess(user, userType);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loginLoading,
    TResult? Function(User user, String userType)? loginSuccess,
    TResult? Function(String error)? loginError,
    TResult? Function()? signedOutStateLoading,
    TResult? Function()? signedOutStateSuccess,
    TResult? Function(String message)? signedOutStateError,
  }) {
    return loginSuccess?.call(user, userType);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loginLoading,
    TResult Function(User user, String userType)? loginSuccess,
    TResult Function(String error)? loginError,
    TResult Function()? signedOutStateLoading,
    TResult Function()? signedOutStateSuccess,
    TResult Function(String message)? signedOutStateError,
    required TResult orElse(),
  }) {
    if (loginSuccess != null) {
      return loginSuccess(user, userType);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginInitial<T> value) initial,
    required TResult Function(LoginLoading<T> value) loginLoading,
    required TResult Function(LoginSuccess<T> value) loginSuccess,
    required TResult Function(LoginError<T> value) loginError,
    required TResult Function(SignedOutStateLoading<T> value)
    signedOutStateLoading,
    required TResult Function(SignedOutStateSuccess<T> value)
    signedOutStateSuccess,
    required TResult Function(SignedOutStateError<T> value) signedOutStateError,
  }) {
    return loginSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginInitial<T> value)? initial,
    TResult? Function(LoginLoading<T> value)? loginLoading,
    TResult? Function(LoginSuccess<T> value)? loginSuccess,
    TResult? Function(LoginError<T> value)? loginError,
    TResult? Function(SignedOutStateLoading<T> value)? signedOutStateLoading,
    TResult? Function(SignedOutStateSuccess<T> value)? signedOutStateSuccess,
    TResult? Function(SignedOutStateError<T> value)? signedOutStateError,
  }) {
    return loginSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginInitial<T> value)? initial,
    TResult Function(LoginLoading<T> value)? loginLoading,
    TResult Function(LoginSuccess<T> value)? loginSuccess,
    TResult Function(LoginError<T> value)? loginError,
    TResult Function(SignedOutStateLoading<T> value)? signedOutStateLoading,
    TResult Function(SignedOutStateSuccess<T> value)? signedOutStateSuccess,
    TResult Function(SignedOutStateError<T> value)? signedOutStateError,
    required TResult orElse(),
  }) {
    if (loginSuccess != null) {
      return loginSuccess(this);
    }
    return orElse();
  }
}

abstract class LoginSuccess<T> implements AuthState<T> {
  const factory LoginSuccess(final User user, final String userType) =
      _$LoginSuccessImpl<T>;

  User get user;
  String get userType;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginSuccessImplCopyWith<T, _$LoginSuccessImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoginErrorImplCopyWith<T, $Res> {
  factory _$$LoginErrorImplCopyWith(
    _$LoginErrorImpl<T> value,
    $Res Function(_$LoginErrorImpl<T>) then,
  ) = __$$LoginErrorImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$LoginErrorImplCopyWithImpl<T, $Res>
    extends _$AuthStateCopyWithImpl<T, $Res, _$LoginErrorImpl<T>>
    implements _$$LoginErrorImplCopyWith<T, $Res> {
  __$$LoginErrorImplCopyWithImpl(
    _$LoginErrorImpl<T> _value,
    $Res Function(_$LoginErrorImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? error = null}) {
    return _then(
      _$LoginErrorImpl<T>(
        null == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class _$LoginErrorImpl<T> implements LoginError<T> {
  const _$LoginErrorImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'AuthState<$T>.loginError(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginErrorImpl<T> &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginErrorImplCopyWith<T, _$LoginErrorImpl<T>> get copyWith =>
      __$$LoginErrorImplCopyWithImpl<T, _$LoginErrorImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loginLoading,
    required TResult Function(User user, String userType) loginSuccess,
    required TResult Function(String error) loginError,
    required TResult Function() signedOutStateLoading,
    required TResult Function() signedOutStateSuccess,
    required TResult Function(String message) signedOutStateError,
  }) {
    return loginError(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loginLoading,
    TResult? Function(User user, String userType)? loginSuccess,
    TResult? Function(String error)? loginError,
    TResult? Function()? signedOutStateLoading,
    TResult? Function()? signedOutStateSuccess,
    TResult? Function(String message)? signedOutStateError,
  }) {
    return loginError?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loginLoading,
    TResult Function(User user, String userType)? loginSuccess,
    TResult Function(String error)? loginError,
    TResult Function()? signedOutStateLoading,
    TResult Function()? signedOutStateSuccess,
    TResult Function(String message)? signedOutStateError,
    required TResult orElse(),
  }) {
    if (loginError != null) {
      return loginError(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginInitial<T> value) initial,
    required TResult Function(LoginLoading<T> value) loginLoading,
    required TResult Function(LoginSuccess<T> value) loginSuccess,
    required TResult Function(LoginError<T> value) loginError,
    required TResult Function(SignedOutStateLoading<T> value)
    signedOutStateLoading,
    required TResult Function(SignedOutStateSuccess<T> value)
    signedOutStateSuccess,
    required TResult Function(SignedOutStateError<T> value) signedOutStateError,
  }) {
    return loginError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginInitial<T> value)? initial,
    TResult? Function(LoginLoading<T> value)? loginLoading,
    TResult? Function(LoginSuccess<T> value)? loginSuccess,
    TResult? Function(LoginError<T> value)? loginError,
    TResult? Function(SignedOutStateLoading<T> value)? signedOutStateLoading,
    TResult? Function(SignedOutStateSuccess<T> value)? signedOutStateSuccess,
    TResult? Function(SignedOutStateError<T> value)? signedOutStateError,
  }) {
    return loginError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginInitial<T> value)? initial,
    TResult Function(LoginLoading<T> value)? loginLoading,
    TResult Function(LoginSuccess<T> value)? loginSuccess,
    TResult Function(LoginError<T> value)? loginError,
    TResult Function(SignedOutStateLoading<T> value)? signedOutStateLoading,
    TResult Function(SignedOutStateSuccess<T> value)? signedOutStateSuccess,
    TResult Function(SignedOutStateError<T> value)? signedOutStateError,
    required TResult orElse(),
  }) {
    if (loginError != null) {
      return loginError(this);
    }
    return orElse();
  }
}

abstract class LoginError<T> implements AuthState<T> {
  const factory LoginError(final String error) = _$LoginErrorImpl<T>;

  String get error;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginErrorImplCopyWith<T, _$LoginErrorImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SignedOutStateLoadingImplCopyWith<T, $Res> {
  factory _$$SignedOutStateLoadingImplCopyWith(
    _$SignedOutStateLoadingImpl<T> value,
    $Res Function(_$SignedOutStateLoadingImpl<T>) then,
  ) = __$$SignedOutStateLoadingImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$SignedOutStateLoadingImplCopyWithImpl<T, $Res>
    extends _$AuthStateCopyWithImpl<T, $Res, _$SignedOutStateLoadingImpl<T>>
    implements _$$SignedOutStateLoadingImplCopyWith<T, $Res> {
  __$$SignedOutStateLoadingImplCopyWithImpl(
    _$SignedOutStateLoadingImpl<T> _value,
    $Res Function(_$SignedOutStateLoadingImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SignedOutStateLoadingImpl<T> implements SignedOutStateLoading<T> {
  const _$SignedOutStateLoadingImpl();

  @override
  String toString() {
    return 'AuthState<$T>.signedOutStateLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignedOutStateLoadingImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loginLoading,
    required TResult Function(User user, String userType) loginSuccess,
    required TResult Function(String error) loginError,
    required TResult Function() signedOutStateLoading,
    required TResult Function() signedOutStateSuccess,
    required TResult Function(String message) signedOutStateError,
  }) {
    return signedOutStateLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loginLoading,
    TResult? Function(User user, String userType)? loginSuccess,
    TResult? Function(String error)? loginError,
    TResult? Function()? signedOutStateLoading,
    TResult? Function()? signedOutStateSuccess,
    TResult? Function(String message)? signedOutStateError,
  }) {
    return signedOutStateLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loginLoading,
    TResult Function(User user, String userType)? loginSuccess,
    TResult Function(String error)? loginError,
    TResult Function()? signedOutStateLoading,
    TResult Function()? signedOutStateSuccess,
    TResult Function(String message)? signedOutStateError,
    required TResult orElse(),
  }) {
    if (signedOutStateLoading != null) {
      return signedOutStateLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginInitial<T> value) initial,
    required TResult Function(LoginLoading<T> value) loginLoading,
    required TResult Function(LoginSuccess<T> value) loginSuccess,
    required TResult Function(LoginError<T> value) loginError,
    required TResult Function(SignedOutStateLoading<T> value)
    signedOutStateLoading,
    required TResult Function(SignedOutStateSuccess<T> value)
    signedOutStateSuccess,
    required TResult Function(SignedOutStateError<T> value) signedOutStateError,
  }) {
    return signedOutStateLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginInitial<T> value)? initial,
    TResult? Function(LoginLoading<T> value)? loginLoading,
    TResult? Function(LoginSuccess<T> value)? loginSuccess,
    TResult? Function(LoginError<T> value)? loginError,
    TResult? Function(SignedOutStateLoading<T> value)? signedOutStateLoading,
    TResult? Function(SignedOutStateSuccess<T> value)? signedOutStateSuccess,
    TResult? Function(SignedOutStateError<T> value)? signedOutStateError,
  }) {
    return signedOutStateLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginInitial<T> value)? initial,
    TResult Function(LoginLoading<T> value)? loginLoading,
    TResult Function(LoginSuccess<T> value)? loginSuccess,
    TResult Function(LoginError<T> value)? loginError,
    TResult Function(SignedOutStateLoading<T> value)? signedOutStateLoading,
    TResult Function(SignedOutStateSuccess<T> value)? signedOutStateSuccess,
    TResult Function(SignedOutStateError<T> value)? signedOutStateError,
    required TResult orElse(),
  }) {
    if (signedOutStateLoading != null) {
      return signedOutStateLoading(this);
    }
    return orElse();
  }
}

abstract class SignedOutStateLoading<T> implements AuthState<T> {
  const factory SignedOutStateLoading() = _$SignedOutStateLoadingImpl<T>;
}

/// @nodoc
abstract class _$$SignedOutStateSuccessImplCopyWith<T, $Res> {
  factory _$$SignedOutStateSuccessImplCopyWith(
    _$SignedOutStateSuccessImpl<T> value,
    $Res Function(_$SignedOutStateSuccessImpl<T>) then,
  ) = __$$SignedOutStateSuccessImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$SignedOutStateSuccessImplCopyWithImpl<T, $Res>
    extends _$AuthStateCopyWithImpl<T, $Res, _$SignedOutStateSuccessImpl<T>>
    implements _$$SignedOutStateSuccessImplCopyWith<T, $Res> {
  __$$SignedOutStateSuccessImplCopyWithImpl(
    _$SignedOutStateSuccessImpl<T> _value,
    $Res Function(_$SignedOutStateSuccessImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SignedOutStateSuccessImpl<T> implements SignedOutStateSuccess<T> {
  const _$SignedOutStateSuccessImpl();

  @override
  String toString() {
    return 'AuthState<$T>.signedOutStateSuccess()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignedOutStateSuccessImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loginLoading,
    required TResult Function(User user, String userType) loginSuccess,
    required TResult Function(String error) loginError,
    required TResult Function() signedOutStateLoading,
    required TResult Function() signedOutStateSuccess,
    required TResult Function(String message) signedOutStateError,
  }) {
    return signedOutStateSuccess();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loginLoading,
    TResult? Function(User user, String userType)? loginSuccess,
    TResult? Function(String error)? loginError,
    TResult? Function()? signedOutStateLoading,
    TResult? Function()? signedOutStateSuccess,
    TResult? Function(String message)? signedOutStateError,
  }) {
    return signedOutStateSuccess?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loginLoading,
    TResult Function(User user, String userType)? loginSuccess,
    TResult Function(String error)? loginError,
    TResult Function()? signedOutStateLoading,
    TResult Function()? signedOutStateSuccess,
    TResult Function(String message)? signedOutStateError,
    required TResult orElse(),
  }) {
    if (signedOutStateSuccess != null) {
      return signedOutStateSuccess();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginInitial<T> value) initial,
    required TResult Function(LoginLoading<T> value) loginLoading,
    required TResult Function(LoginSuccess<T> value) loginSuccess,
    required TResult Function(LoginError<T> value) loginError,
    required TResult Function(SignedOutStateLoading<T> value)
    signedOutStateLoading,
    required TResult Function(SignedOutStateSuccess<T> value)
    signedOutStateSuccess,
    required TResult Function(SignedOutStateError<T> value) signedOutStateError,
  }) {
    return signedOutStateSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginInitial<T> value)? initial,
    TResult? Function(LoginLoading<T> value)? loginLoading,
    TResult? Function(LoginSuccess<T> value)? loginSuccess,
    TResult? Function(LoginError<T> value)? loginError,
    TResult? Function(SignedOutStateLoading<T> value)? signedOutStateLoading,
    TResult? Function(SignedOutStateSuccess<T> value)? signedOutStateSuccess,
    TResult? Function(SignedOutStateError<T> value)? signedOutStateError,
  }) {
    return signedOutStateSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginInitial<T> value)? initial,
    TResult Function(LoginLoading<T> value)? loginLoading,
    TResult Function(LoginSuccess<T> value)? loginSuccess,
    TResult Function(LoginError<T> value)? loginError,
    TResult Function(SignedOutStateLoading<T> value)? signedOutStateLoading,
    TResult Function(SignedOutStateSuccess<T> value)? signedOutStateSuccess,
    TResult Function(SignedOutStateError<T> value)? signedOutStateError,
    required TResult orElse(),
  }) {
    if (signedOutStateSuccess != null) {
      return signedOutStateSuccess(this);
    }
    return orElse();
  }
}

abstract class SignedOutStateSuccess<T> implements AuthState<T> {
  const factory SignedOutStateSuccess() = _$SignedOutStateSuccessImpl<T>;
}

/// @nodoc
abstract class _$$SignedOutStateErrorImplCopyWith<T, $Res> {
  factory _$$SignedOutStateErrorImplCopyWith(
    _$SignedOutStateErrorImpl<T> value,
    $Res Function(_$SignedOutStateErrorImpl<T>) then,
  ) = __$$SignedOutStateErrorImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$SignedOutStateErrorImplCopyWithImpl<T, $Res>
    extends _$AuthStateCopyWithImpl<T, $Res, _$SignedOutStateErrorImpl<T>>
    implements _$$SignedOutStateErrorImplCopyWith<T, $Res> {
  __$$SignedOutStateErrorImplCopyWithImpl(
    _$SignedOutStateErrorImpl<T> _value,
    $Res Function(_$SignedOutStateErrorImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$SignedOutStateErrorImpl<T>(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class _$SignedOutStateErrorImpl<T> implements SignedOutStateError<T> {
  const _$SignedOutStateErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'AuthState<$T>.signedOutStateError(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignedOutStateErrorImpl<T> &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignedOutStateErrorImplCopyWith<T, _$SignedOutStateErrorImpl<T>>
  get copyWith =>
      __$$SignedOutStateErrorImplCopyWithImpl<T, _$SignedOutStateErrorImpl<T>>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loginLoading,
    required TResult Function(User user, String userType) loginSuccess,
    required TResult Function(String error) loginError,
    required TResult Function() signedOutStateLoading,
    required TResult Function() signedOutStateSuccess,
    required TResult Function(String message) signedOutStateError,
  }) {
    return signedOutStateError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loginLoading,
    TResult? Function(User user, String userType)? loginSuccess,
    TResult? Function(String error)? loginError,
    TResult? Function()? signedOutStateLoading,
    TResult? Function()? signedOutStateSuccess,
    TResult? Function(String message)? signedOutStateError,
  }) {
    return signedOutStateError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loginLoading,
    TResult Function(User user, String userType)? loginSuccess,
    TResult Function(String error)? loginError,
    TResult Function()? signedOutStateLoading,
    TResult Function()? signedOutStateSuccess,
    TResult Function(String message)? signedOutStateError,
    required TResult orElse(),
  }) {
    if (signedOutStateError != null) {
      return signedOutStateError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginInitial<T> value) initial,
    required TResult Function(LoginLoading<T> value) loginLoading,
    required TResult Function(LoginSuccess<T> value) loginSuccess,
    required TResult Function(LoginError<T> value) loginError,
    required TResult Function(SignedOutStateLoading<T> value)
    signedOutStateLoading,
    required TResult Function(SignedOutStateSuccess<T> value)
    signedOutStateSuccess,
    required TResult Function(SignedOutStateError<T> value) signedOutStateError,
  }) {
    return signedOutStateError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginInitial<T> value)? initial,
    TResult? Function(LoginLoading<T> value)? loginLoading,
    TResult? Function(LoginSuccess<T> value)? loginSuccess,
    TResult? Function(LoginError<T> value)? loginError,
    TResult? Function(SignedOutStateLoading<T> value)? signedOutStateLoading,
    TResult? Function(SignedOutStateSuccess<T> value)? signedOutStateSuccess,
    TResult? Function(SignedOutStateError<T> value)? signedOutStateError,
  }) {
    return signedOutStateError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginInitial<T> value)? initial,
    TResult Function(LoginLoading<T> value)? loginLoading,
    TResult Function(LoginSuccess<T> value)? loginSuccess,
    TResult Function(LoginError<T> value)? loginError,
    TResult Function(SignedOutStateLoading<T> value)? signedOutStateLoading,
    TResult Function(SignedOutStateSuccess<T> value)? signedOutStateSuccess,
    TResult Function(SignedOutStateError<T> value)? signedOutStateError,
    required TResult orElse(),
  }) {
    if (signedOutStateError != null) {
      return signedOutStateError(this);
    }
    return orElse();
  }
}

abstract class SignedOutStateError<T> implements AuthState<T> {
  const factory SignedOutStateError(final String message) =
      _$SignedOutStateErrorImpl<T>;

  String get message;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignedOutStateErrorImplCopyWith<T, _$SignedOutStateErrorImpl<T>>
  get copyWith => throw _privateConstructorUsedError;
}
