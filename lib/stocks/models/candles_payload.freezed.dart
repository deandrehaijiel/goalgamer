// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'candles_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CandlesPayload _$CandlesPayloadFromJson(Map<String, dynamic> json) {
  return _CandlesPayload.fromJson(json);
}

/// @nodoc
mixin _$CandlesPayload {
  @JsonKey(name: 'c', defaultValue: [])
  List<double> get close => throw _privateConstructorUsedError;
  @JsonKey(name: 'h', defaultValue: [])
  List<double> get high => throw _privateConstructorUsedError;
  @JsonKey(name: 'l', defaultValue: [])
  List<double> get low => throw _privateConstructorUsedError;
  @JsonKey(name: 'o', defaultValue: [])
  List<double> get open => throw _privateConstructorUsedError;
  @JsonKey(name: 't', defaultValue: [])
  List<int> get unixTimestamp => throw _privateConstructorUsedError;
  @JsonKey(name: 'v', defaultValue: [])
  List<double> get volume => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CandlesPayloadCopyWith<CandlesPayload> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CandlesPayloadCopyWith<$Res> {
  factory $CandlesPayloadCopyWith(
          CandlesPayload value, $Res Function(CandlesPayload) then) =
      _$CandlesPayloadCopyWithImpl<$Res, CandlesPayload>;
  @useResult
  $Res call(
      {@JsonKey(name: 'c', defaultValue: []) List<double> close,
      @JsonKey(name: 'h', defaultValue: []) List<double> high,
      @JsonKey(name: 'l', defaultValue: []) List<double> low,
      @JsonKey(name: 'o', defaultValue: []) List<double> open,
      @JsonKey(name: 't', defaultValue: []) List<int> unixTimestamp,
      @JsonKey(name: 'v', defaultValue: []) List<double> volume});
}

/// @nodoc
class _$CandlesPayloadCopyWithImpl<$Res, $Val extends CandlesPayload>
    implements $CandlesPayloadCopyWith<$Res> {
  _$CandlesPayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? close = null,
    Object? high = null,
    Object? low = null,
    Object? open = null,
    Object? unixTimestamp = null,
    Object? volume = null,
  }) {
    return _then(_value.copyWith(
      close: null == close
          ? _value.close
          : close // ignore: cast_nullable_to_non_nullable
              as List<double>,
      high: null == high
          ? _value.high
          : high // ignore: cast_nullable_to_non_nullable
              as List<double>,
      low: null == low
          ? _value.low
          : low // ignore: cast_nullable_to_non_nullable
              as List<double>,
      open: null == open
          ? _value.open
          : open // ignore: cast_nullable_to_non_nullable
              as List<double>,
      unixTimestamp: null == unixTimestamp
          ? _value.unixTimestamp
          : unixTimestamp // ignore: cast_nullable_to_non_nullable
              as List<int>,
      volume: null == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CandlesPayloadCopyWith<$Res>
    implements $CandlesPayloadCopyWith<$Res> {
  factory _$$_CandlesPayloadCopyWith(
          _$_CandlesPayload value, $Res Function(_$_CandlesPayload) then) =
      __$$_CandlesPayloadCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'c', defaultValue: []) List<double> close,
      @JsonKey(name: 'h', defaultValue: []) List<double> high,
      @JsonKey(name: 'l', defaultValue: []) List<double> low,
      @JsonKey(name: 'o', defaultValue: []) List<double> open,
      @JsonKey(name: 't', defaultValue: []) List<int> unixTimestamp,
      @JsonKey(name: 'v', defaultValue: []) List<double> volume});
}

/// @nodoc
class __$$_CandlesPayloadCopyWithImpl<$Res>
    extends _$CandlesPayloadCopyWithImpl<$Res, _$_CandlesPayload>
    implements _$$_CandlesPayloadCopyWith<$Res> {
  __$$_CandlesPayloadCopyWithImpl(
      _$_CandlesPayload _value, $Res Function(_$_CandlesPayload) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? close = null,
    Object? high = null,
    Object? low = null,
    Object? open = null,
    Object? unixTimestamp = null,
    Object? volume = null,
  }) {
    return _then(_$_CandlesPayload(
      null == close
          ? _value._close
          : close // ignore: cast_nullable_to_non_nullable
              as List<double>,
      null == high
          ? _value._high
          : high // ignore: cast_nullable_to_non_nullable
              as List<double>,
      null == low
          ? _value._low
          : low // ignore: cast_nullable_to_non_nullable
              as List<double>,
      null == open
          ? _value._open
          : open // ignore: cast_nullable_to_non_nullable
              as List<double>,
      null == unixTimestamp
          ? _value._unixTimestamp
          : unixTimestamp // ignore: cast_nullable_to_non_nullable
              as List<int>,
      null == volume
          ? _value._volume
          : volume // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_CandlesPayload extends _CandlesPayload {
  _$_CandlesPayload(
      @JsonKey(name: 'c', defaultValue: []) final List<double> close,
      @JsonKey(name: 'h', defaultValue: []) final List<double> high,
      @JsonKey(name: 'l', defaultValue: []) final List<double> low,
      @JsonKey(name: 'o', defaultValue: []) final List<double> open,
      @JsonKey(name: 't', defaultValue: []) final List<int> unixTimestamp,
      @JsonKey(name: 'v', defaultValue: []) final List<double> volume)
      : _close = close,
        _high = high,
        _low = low,
        _open = open,
        _unixTimestamp = unixTimestamp,
        _volume = volume,
        super._();

  factory _$_CandlesPayload.fromJson(Map<String, dynamic> json) =>
      _$$_CandlesPayloadFromJson(json);

  final List<double> _close;
  @override
  @JsonKey(name: 'c', defaultValue: [])
  List<double> get close {
    if (_close is EqualUnmodifiableListView) return _close;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_close);
  }

  final List<double> _high;
  @override
  @JsonKey(name: 'h', defaultValue: [])
  List<double> get high {
    if (_high is EqualUnmodifiableListView) return _high;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_high);
  }

  final List<double> _low;
  @override
  @JsonKey(name: 'l', defaultValue: [])
  List<double> get low {
    if (_low is EqualUnmodifiableListView) return _low;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_low);
  }

  final List<double> _open;
  @override
  @JsonKey(name: 'o', defaultValue: [])
  List<double> get open {
    if (_open is EqualUnmodifiableListView) return _open;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_open);
  }

  final List<int> _unixTimestamp;
  @override
  @JsonKey(name: 't', defaultValue: [])
  List<int> get unixTimestamp {
    if (_unixTimestamp is EqualUnmodifiableListView) return _unixTimestamp;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_unixTimestamp);
  }

  final List<double> _volume;
  @override
  @JsonKey(name: 'v', defaultValue: [])
  List<double> get volume {
    if (_volume is EqualUnmodifiableListView) return _volume;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_volume);
  }

  @override
  String toString() {
    return 'CandlesPayload(close: $close, high: $high, low: $low, open: $open, unixTimestamp: $unixTimestamp, volume: $volume)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CandlesPayload &&
            const DeepCollectionEquality().equals(other._close, _close) &&
            const DeepCollectionEquality().equals(other._high, _high) &&
            const DeepCollectionEquality().equals(other._low, _low) &&
            const DeepCollectionEquality().equals(other._open, _open) &&
            const DeepCollectionEquality()
                .equals(other._unixTimestamp, _unixTimestamp) &&
            const DeepCollectionEquality().equals(other._volume, _volume));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_close),
      const DeepCollectionEquality().hash(_high),
      const DeepCollectionEquality().hash(_low),
      const DeepCollectionEquality().hash(_open),
      const DeepCollectionEquality().hash(_unixTimestamp),
      const DeepCollectionEquality().hash(_volume));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CandlesPayloadCopyWith<_$_CandlesPayload> get copyWith =>
      __$$_CandlesPayloadCopyWithImpl<_$_CandlesPayload>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CandlesPayloadToJson(
      this,
    );
  }
}

abstract class _CandlesPayload extends CandlesPayload {
  factory _CandlesPayload(
          @JsonKey(name: 'c', defaultValue: []) final List<double> close,
          @JsonKey(name: 'h', defaultValue: []) final List<double> high,
          @JsonKey(name: 'l', defaultValue: []) final List<double> low,
          @JsonKey(name: 'o', defaultValue: []) final List<double> open,
          @JsonKey(name: 't', defaultValue: []) final List<int> unixTimestamp,
          @JsonKey(name: 'v', defaultValue: []) final List<double> volume) =
      _$_CandlesPayload;
  _CandlesPayload._() : super._();

  factory _CandlesPayload.fromJson(Map<String, dynamic> json) =
      _$_CandlesPayload.fromJson;

  @override
  @JsonKey(name: 'c', defaultValue: [])
  List<double> get close;
  @override
  @JsonKey(name: 'h', defaultValue: [])
  List<double> get high;
  @override
  @JsonKey(name: 'l', defaultValue: [])
  List<double> get low;
  @override
  @JsonKey(name: 'o', defaultValue: [])
  List<double> get open;
  @override
  @JsonKey(name: 't', defaultValue: [])
  List<int> get unixTimestamp;
  @override
  @JsonKey(name: 'v', defaultValue: [])
  List<double> get volume;
  @override
  @JsonKey(ignore: true)
  _$$_CandlesPayloadCopyWith<_$_CandlesPayload> get copyWith =>
      throw _privateConstructorUsedError;
}
