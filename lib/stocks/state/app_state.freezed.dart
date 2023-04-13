// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppState {
  List<Candle> get candles => throw _privateConstructorUsedError;
  String? get currentSymbol => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get hasError => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  GetCandlesRequest? get recentQuery => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppStateCopyWith<AppState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) then) =
      _$AppStateCopyWithImpl<$Res, AppState>;
  @useResult
  $Res call(
      {List<Candle> candles,
      String? currentSymbol,
      bool isLoading,
      bool hasError,
      String? errorMessage,
      GetCandlesRequest? recentQuery});

  $GetCandlesRequestCopyWith<$Res>? get recentQuery;
}

/// @nodoc
class _$AppStateCopyWithImpl<$Res, $Val extends AppState>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? candles = null,
    Object? currentSymbol = freezed,
    Object? isLoading = null,
    Object? hasError = null,
    Object? errorMessage = freezed,
    Object? recentQuery = freezed,
  }) {
    return _then(_value.copyWith(
      candles: null == candles
          ? _value.candles
          : candles // ignore: cast_nullable_to_non_nullable
              as List<Candle>,
      currentSymbol: freezed == currentSymbol
          ? _value.currentSymbol
          : currentSymbol // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      hasError: null == hasError
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      recentQuery: freezed == recentQuery
          ? _value.recentQuery
          : recentQuery // ignore: cast_nullable_to_non_nullable
              as GetCandlesRequest?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GetCandlesRequestCopyWith<$Res>? get recentQuery {
    if (_value.recentQuery == null) {
      return null;
    }

    return $GetCandlesRequestCopyWith<$Res>(_value.recentQuery!, (value) {
      return _then(_value.copyWith(recentQuery: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_AppStateCopyWith<$Res> implements $AppStateCopyWith<$Res> {
  factory _$$_AppStateCopyWith(
          _$_AppState value, $Res Function(_$_AppState) then) =
      __$$_AppStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Candle> candles,
      String? currentSymbol,
      bool isLoading,
      bool hasError,
      String? errorMessage,
      GetCandlesRequest? recentQuery});

  @override
  $GetCandlesRequestCopyWith<$Res>? get recentQuery;
}

/// @nodoc
class __$$_AppStateCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$_AppState>
    implements _$$_AppStateCopyWith<$Res> {
  __$$_AppStateCopyWithImpl(
      _$_AppState _value, $Res Function(_$_AppState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? candles = null,
    Object? currentSymbol = freezed,
    Object? isLoading = null,
    Object? hasError = null,
    Object? errorMessage = freezed,
    Object? recentQuery = freezed,
  }) {
    return _then(_$_AppState(
      null == candles
          ? _value._candles
          : candles // ignore: cast_nullable_to_non_nullable
              as List<Candle>,
      freezed == currentSymbol
          ? _value.currentSymbol
          : currentSymbol // ignore: cast_nullable_to_non_nullable
              as String?,
      null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      null == hasError
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == recentQuery
          ? _value.recentQuery
          : recentQuery // ignore: cast_nullable_to_non_nullable
              as GetCandlesRequest?,
    ));
  }
}

/// @nodoc

class _$_AppState implements _AppState {
  _$_AppState(final List<Candle> candles, this.currentSymbol, this.isLoading,
      this.hasError, this.errorMessage, this.recentQuery)
      : _candles = candles;

  final List<Candle> _candles;
  @override
  List<Candle> get candles {
    if (_candles is EqualUnmodifiableListView) return _candles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_candles);
  }

  @override
  final String? currentSymbol;
  @override
  final bool isLoading;
  @override
  final bool hasError;
  @override
  final String? errorMessage;
  @override
  final GetCandlesRequest? recentQuery;

  @override
  String toString() {
    return 'AppState(candles: $candles, currentSymbol: $currentSymbol, isLoading: $isLoading, hasError: $hasError, errorMessage: $errorMessage, recentQuery: $recentQuery)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppState &&
            const DeepCollectionEquality().equals(other._candles, _candles) &&
            (identical(other.currentSymbol, currentSymbol) ||
                other.currentSymbol == currentSymbol) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.hasError, hasError) ||
                other.hasError == hasError) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.recentQuery, recentQuery) ||
                other.recentQuery == recentQuery));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_candles),
      currentSymbol,
      isLoading,
      hasError,
      errorMessage,
      recentQuery);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppStateCopyWith<_$_AppState> get copyWith =>
      __$$_AppStateCopyWithImpl<_$_AppState>(this, _$identity);
}

abstract class _AppState implements AppState {
  factory _AppState(
      final List<Candle> candles,
      final String? currentSymbol,
      final bool isLoading,
      final bool hasError,
      final String? errorMessage,
      final GetCandlesRequest? recentQuery) = _$_AppState;

  @override
  List<Candle> get candles;
  @override
  String? get currentSymbol;
  @override
  bool get isLoading;
  @override
  bool get hasError;
  @override
  String? get errorMessage;
  @override
  GetCandlesRequest? get recentQuery;
  @override
  @JsonKey(ignore: true)
  _$$_AppStateCopyWith<_$_AppState> get copyWith =>
      throw _privateConstructorUsedError;
}
