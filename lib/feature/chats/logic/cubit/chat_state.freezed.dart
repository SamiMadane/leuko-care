// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ChatState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() chatInitial,
    required TResult Function() chatLoading,
    required TResult Function(List<ChatModel> messages) chatSuccess,
    required TResult Function(String message) chatError,
    required TResult Function() chatMessageSentSuccessfully,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? chatInitial,
    TResult? Function()? chatLoading,
    TResult? Function(List<ChatModel> messages)? chatSuccess,
    TResult? Function(String message)? chatError,
    TResult? Function()? chatMessageSentSuccessfully,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? chatInitial,
    TResult Function()? chatLoading,
    TResult Function(List<ChatModel> messages)? chatSuccess,
    TResult Function(String message)? chatError,
    TResult Function()? chatMessageSentSuccessfully,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ChatInitial value) chatInitial,
    required TResult Function(ChatLoading value) chatLoading,
    required TResult Function(ChatSuccess value) chatSuccess,
    required TResult Function(ChatError value) chatError,
    required TResult Function(ChatMessageSentSuccessfully value)
    chatMessageSentSuccessfully,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ChatInitial value)? chatInitial,
    TResult? Function(ChatLoading value)? chatLoading,
    TResult? Function(ChatSuccess value)? chatSuccess,
    TResult? Function(ChatError value)? chatError,
    TResult? Function(ChatMessageSentSuccessfully value)?
    chatMessageSentSuccessfully,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ChatInitial value)? chatInitial,
    TResult Function(ChatLoading value)? chatLoading,
    TResult Function(ChatSuccess value)? chatSuccess,
    TResult Function(ChatError value)? chatError,
    TResult Function(ChatMessageSentSuccessfully value)?
    chatMessageSentSuccessfully,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatStateCopyWith<$Res> {
  factory $ChatStateCopyWith(ChatState value, $Res Function(ChatState) then) =
      _$ChatStateCopyWithImpl<$Res, ChatState>;
}

/// @nodoc
class _$ChatStateCopyWithImpl<$Res, $Val extends ChatState>
    implements $ChatStateCopyWith<$Res> {
  _$ChatStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ChatInitialImplCopyWith<$Res> {
  factory _$$ChatInitialImplCopyWith(
    _$ChatInitialImpl value,
    $Res Function(_$ChatInitialImpl) then,
  ) = __$$ChatInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ChatInitialImplCopyWithImpl<$Res>
    extends _$ChatStateCopyWithImpl<$Res, _$ChatInitialImpl>
    implements _$$ChatInitialImplCopyWith<$Res> {
  __$$ChatInitialImplCopyWithImpl(
    _$ChatInitialImpl _value,
    $Res Function(_$ChatInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ChatInitialImpl implements _ChatInitial {
  const _$ChatInitialImpl();

  @override
  String toString() {
    return 'ChatState.chatInitial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ChatInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() chatInitial,
    required TResult Function() chatLoading,
    required TResult Function(List<ChatModel> messages) chatSuccess,
    required TResult Function(String message) chatError,
    required TResult Function() chatMessageSentSuccessfully,
  }) {
    return chatInitial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? chatInitial,
    TResult? Function()? chatLoading,
    TResult? Function(List<ChatModel> messages)? chatSuccess,
    TResult? Function(String message)? chatError,
    TResult? Function()? chatMessageSentSuccessfully,
  }) {
    return chatInitial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? chatInitial,
    TResult Function()? chatLoading,
    TResult Function(List<ChatModel> messages)? chatSuccess,
    TResult Function(String message)? chatError,
    TResult Function()? chatMessageSentSuccessfully,
    required TResult orElse(),
  }) {
    if (chatInitial != null) {
      return chatInitial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ChatInitial value) chatInitial,
    required TResult Function(ChatLoading value) chatLoading,
    required TResult Function(ChatSuccess value) chatSuccess,
    required TResult Function(ChatError value) chatError,
    required TResult Function(ChatMessageSentSuccessfully value)
    chatMessageSentSuccessfully,
  }) {
    return chatInitial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ChatInitial value)? chatInitial,
    TResult? Function(ChatLoading value)? chatLoading,
    TResult? Function(ChatSuccess value)? chatSuccess,
    TResult? Function(ChatError value)? chatError,
    TResult? Function(ChatMessageSentSuccessfully value)?
    chatMessageSentSuccessfully,
  }) {
    return chatInitial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ChatInitial value)? chatInitial,
    TResult Function(ChatLoading value)? chatLoading,
    TResult Function(ChatSuccess value)? chatSuccess,
    TResult Function(ChatError value)? chatError,
    TResult Function(ChatMessageSentSuccessfully value)?
    chatMessageSentSuccessfully,
    required TResult orElse(),
  }) {
    if (chatInitial != null) {
      return chatInitial(this);
    }
    return orElse();
  }
}

abstract class _ChatInitial implements ChatState {
  const factory _ChatInitial() = _$ChatInitialImpl;
}

/// @nodoc
abstract class _$$ChatLoadingImplCopyWith<$Res> {
  factory _$$ChatLoadingImplCopyWith(
    _$ChatLoadingImpl value,
    $Res Function(_$ChatLoadingImpl) then,
  ) = __$$ChatLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ChatLoadingImplCopyWithImpl<$Res>
    extends _$ChatStateCopyWithImpl<$Res, _$ChatLoadingImpl>
    implements _$$ChatLoadingImplCopyWith<$Res> {
  __$$ChatLoadingImplCopyWithImpl(
    _$ChatLoadingImpl _value,
    $Res Function(_$ChatLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ChatLoadingImpl implements ChatLoading {
  const _$ChatLoadingImpl();

  @override
  String toString() {
    return 'ChatState.chatLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ChatLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() chatInitial,
    required TResult Function() chatLoading,
    required TResult Function(List<ChatModel> messages) chatSuccess,
    required TResult Function(String message) chatError,
    required TResult Function() chatMessageSentSuccessfully,
  }) {
    return chatLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? chatInitial,
    TResult? Function()? chatLoading,
    TResult? Function(List<ChatModel> messages)? chatSuccess,
    TResult? Function(String message)? chatError,
    TResult? Function()? chatMessageSentSuccessfully,
  }) {
    return chatLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? chatInitial,
    TResult Function()? chatLoading,
    TResult Function(List<ChatModel> messages)? chatSuccess,
    TResult Function(String message)? chatError,
    TResult Function()? chatMessageSentSuccessfully,
    required TResult orElse(),
  }) {
    if (chatLoading != null) {
      return chatLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ChatInitial value) chatInitial,
    required TResult Function(ChatLoading value) chatLoading,
    required TResult Function(ChatSuccess value) chatSuccess,
    required TResult Function(ChatError value) chatError,
    required TResult Function(ChatMessageSentSuccessfully value)
    chatMessageSentSuccessfully,
  }) {
    return chatLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ChatInitial value)? chatInitial,
    TResult? Function(ChatLoading value)? chatLoading,
    TResult? Function(ChatSuccess value)? chatSuccess,
    TResult? Function(ChatError value)? chatError,
    TResult? Function(ChatMessageSentSuccessfully value)?
    chatMessageSentSuccessfully,
  }) {
    return chatLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ChatInitial value)? chatInitial,
    TResult Function(ChatLoading value)? chatLoading,
    TResult Function(ChatSuccess value)? chatSuccess,
    TResult Function(ChatError value)? chatError,
    TResult Function(ChatMessageSentSuccessfully value)?
    chatMessageSentSuccessfully,
    required TResult orElse(),
  }) {
    if (chatLoading != null) {
      return chatLoading(this);
    }
    return orElse();
  }
}

abstract class ChatLoading implements ChatState {
  const factory ChatLoading() = _$ChatLoadingImpl;
}

/// @nodoc
abstract class _$$ChatSuccessImplCopyWith<$Res> {
  factory _$$ChatSuccessImplCopyWith(
    _$ChatSuccessImpl value,
    $Res Function(_$ChatSuccessImpl) then,
  ) = __$$ChatSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<ChatModel> messages});
}

/// @nodoc
class __$$ChatSuccessImplCopyWithImpl<$Res>
    extends _$ChatStateCopyWithImpl<$Res, _$ChatSuccessImpl>
    implements _$$ChatSuccessImplCopyWith<$Res> {
  __$$ChatSuccessImplCopyWithImpl(
    _$ChatSuccessImpl _value,
    $Res Function(_$ChatSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? messages = null}) {
    return _then(
      _$ChatSuccessImpl(
        null == messages
            ? _value._messages
            : messages // ignore: cast_nullable_to_non_nullable
                as List<ChatModel>,
      ),
    );
  }
}

/// @nodoc

class _$ChatSuccessImpl implements ChatSuccess {
  const _$ChatSuccessImpl(final List<ChatModel> messages)
    : _messages = messages;

  final List<ChatModel> _messages;
  @override
  List<ChatModel> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  String toString() {
    return 'ChatState.chatSuccess(messages: $messages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatSuccessImpl &&
            const DeepCollectionEquality().equals(other._messages, _messages));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_messages));

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatSuccessImplCopyWith<_$ChatSuccessImpl> get copyWith =>
      __$$ChatSuccessImplCopyWithImpl<_$ChatSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() chatInitial,
    required TResult Function() chatLoading,
    required TResult Function(List<ChatModel> messages) chatSuccess,
    required TResult Function(String message) chatError,
    required TResult Function() chatMessageSentSuccessfully,
  }) {
    return chatSuccess(messages);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? chatInitial,
    TResult? Function()? chatLoading,
    TResult? Function(List<ChatModel> messages)? chatSuccess,
    TResult? Function(String message)? chatError,
    TResult? Function()? chatMessageSentSuccessfully,
  }) {
    return chatSuccess?.call(messages);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? chatInitial,
    TResult Function()? chatLoading,
    TResult Function(List<ChatModel> messages)? chatSuccess,
    TResult Function(String message)? chatError,
    TResult Function()? chatMessageSentSuccessfully,
    required TResult orElse(),
  }) {
    if (chatSuccess != null) {
      return chatSuccess(messages);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ChatInitial value) chatInitial,
    required TResult Function(ChatLoading value) chatLoading,
    required TResult Function(ChatSuccess value) chatSuccess,
    required TResult Function(ChatError value) chatError,
    required TResult Function(ChatMessageSentSuccessfully value)
    chatMessageSentSuccessfully,
  }) {
    return chatSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ChatInitial value)? chatInitial,
    TResult? Function(ChatLoading value)? chatLoading,
    TResult? Function(ChatSuccess value)? chatSuccess,
    TResult? Function(ChatError value)? chatError,
    TResult? Function(ChatMessageSentSuccessfully value)?
    chatMessageSentSuccessfully,
  }) {
    return chatSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ChatInitial value)? chatInitial,
    TResult Function(ChatLoading value)? chatLoading,
    TResult Function(ChatSuccess value)? chatSuccess,
    TResult Function(ChatError value)? chatError,
    TResult Function(ChatMessageSentSuccessfully value)?
    chatMessageSentSuccessfully,
    required TResult orElse(),
  }) {
    if (chatSuccess != null) {
      return chatSuccess(this);
    }
    return orElse();
  }
}

abstract class ChatSuccess implements ChatState {
  const factory ChatSuccess(final List<ChatModel> messages) = _$ChatSuccessImpl;

  List<ChatModel> get messages;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatSuccessImplCopyWith<_$ChatSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChatErrorImplCopyWith<$Res> {
  factory _$$ChatErrorImplCopyWith(
    _$ChatErrorImpl value,
    $Res Function(_$ChatErrorImpl) then,
  ) = __$$ChatErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ChatErrorImplCopyWithImpl<$Res>
    extends _$ChatStateCopyWithImpl<$Res, _$ChatErrorImpl>
    implements _$$ChatErrorImplCopyWith<$Res> {
  __$$ChatErrorImplCopyWithImpl(
    _$ChatErrorImpl _value,
    $Res Function(_$ChatErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ChatErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class _$ChatErrorImpl implements ChatError {
  const _$ChatErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'ChatState.chatError(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatErrorImplCopyWith<_$ChatErrorImpl> get copyWith =>
      __$$ChatErrorImplCopyWithImpl<_$ChatErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() chatInitial,
    required TResult Function() chatLoading,
    required TResult Function(List<ChatModel> messages) chatSuccess,
    required TResult Function(String message) chatError,
    required TResult Function() chatMessageSentSuccessfully,
  }) {
    return chatError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? chatInitial,
    TResult? Function()? chatLoading,
    TResult? Function(List<ChatModel> messages)? chatSuccess,
    TResult? Function(String message)? chatError,
    TResult? Function()? chatMessageSentSuccessfully,
  }) {
    return chatError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? chatInitial,
    TResult Function()? chatLoading,
    TResult Function(List<ChatModel> messages)? chatSuccess,
    TResult Function(String message)? chatError,
    TResult Function()? chatMessageSentSuccessfully,
    required TResult orElse(),
  }) {
    if (chatError != null) {
      return chatError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ChatInitial value) chatInitial,
    required TResult Function(ChatLoading value) chatLoading,
    required TResult Function(ChatSuccess value) chatSuccess,
    required TResult Function(ChatError value) chatError,
    required TResult Function(ChatMessageSentSuccessfully value)
    chatMessageSentSuccessfully,
  }) {
    return chatError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ChatInitial value)? chatInitial,
    TResult? Function(ChatLoading value)? chatLoading,
    TResult? Function(ChatSuccess value)? chatSuccess,
    TResult? Function(ChatError value)? chatError,
    TResult? Function(ChatMessageSentSuccessfully value)?
    chatMessageSentSuccessfully,
  }) {
    return chatError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ChatInitial value)? chatInitial,
    TResult Function(ChatLoading value)? chatLoading,
    TResult Function(ChatSuccess value)? chatSuccess,
    TResult Function(ChatError value)? chatError,
    TResult Function(ChatMessageSentSuccessfully value)?
    chatMessageSentSuccessfully,
    required TResult orElse(),
  }) {
    if (chatError != null) {
      return chatError(this);
    }
    return orElse();
  }
}

abstract class ChatError implements ChatState {
  const factory ChatError(final String message) = _$ChatErrorImpl;

  String get message;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatErrorImplCopyWith<_$ChatErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChatMessageSentSuccessfullyImplCopyWith<$Res> {
  factory _$$ChatMessageSentSuccessfullyImplCopyWith(
    _$ChatMessageSentSuccessfullyImpl value,
    $Res Function(_$ChatMessageSentSuccessfullyImpl) then,
  ) = __$$ChatMessageSentSuccessfullyImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ChatMessageSentSuccessfullyImplCopyWithImpl<$Res>
    extends _$ChatStateCopyWithImpl<$Res, _$ChatMessageSentSuccessfullyImpl>
    implements _$$ChatMessageSentSuccessfullyImplCopyWith<$Res> {
  __$$ChatMessageSentSuccessfullyImplCopyWithImpl(
    _$ChatMessageSentSuccessfullyImpl _value,
    $Res Function(_$ChatMessageSentSuccessfullyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ChatMessageSentSuccessfullyImpl implements ChatMessageSentSuccessfully {
  const _$ChatMessageSentSuccessfullyImpl();

  @override
  String toString() {
    return 'ChatState.chatMessageSentSuccessfully()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageSentSuccessfullyImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() chatInitial,
    required TResult Function() chatLoading,
    required TResult Function(List<ChatModel> messages) chatSuccess,
    required TResult Function(String message) chatError,
    required TResult Function() chatMessageSentSuccessfully,
  }) {
    return chatMessageSentSuccessfully();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? chatInitial,
    TResult? Function()? chatLoading,
    TResult? Function(List<ChatModel> messages)? chatSuccess,
    TResult? Function(String message)? chatError,
    TResult? Function()? chatMessageSentSuccessfully,
  }) {
    return chatMessageSentSuccessfully?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? chatInitial,
    TResult Function()? chatLoading,
    TResult Function(List<ChatModel> messages)? chatSuccess,
    TResult Function(String message)? chatError,
    TResult Function()? chatMessageSentSuccessfully,
    required TResult orElse(),
  }) {
    if (chatMessageSentSuccessfully != null) {
      return chatMessageSentSuccessfully();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ChatInitial value) chatInitial,
    required TResult Function(ChatLoading value) chatLoading,
    required TResult Function(ChatSuccess value) chatSuccess,
    required TResult Function(ChatError value) chatError,
    required TResult Function(ChatMessageSentSuccessfully value)
    chatMessageSentSuccessfully,
  }) {
    return chatMessageSentSuccessfully(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ChatInitial value)? chatInitial,
    TResult? Function(ChatLoading value)? chatLoading,
    TResult? Function(ChatSuccess value)? chatSuccess,
    TResult? Function(ChatError value)? chatError,
    TResult? Function(ChatMessageSentSuccessfully value)?
    chatMessageSentSuccessfully,
  }) {
    return chatMessageSentSuccessfully?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ChatInitial value)? chatInitial,
    TResult Function(ChatLoading value)? chatLoading,
    TResult Function(ChatSuccess value)? chatSuccess,
    TResult Function(ChatError value)? chatError,
    TResult Function(ChatMessageSentSuccessfully value)?
    chatMessageSentSuccessfully,
    required TResult orElse(),
  }) {
    if (chatMessageSentSuccessfully != null) {
      return chatMessageSentSuccessfully(this);
    }
    return orElse();
  }
}

abstract class ChatMessageSentSuccessfully implements ChatState {
  const factory ChatMessageSentSuccessfully() =
      _$ChatMessageSentSuccessfullyImpl;
}
