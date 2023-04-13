// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'candle.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Candle {
  double get close => throw _privateConstructorUsedError;
  double get high => throw _privateConstructorUsedError;
  double get low => throw _privateConstructorUsedError;
  double get open => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  double get volume => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CandleCopyWith<Candle> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CandleCopyWith<$Res> {
  factory $CandleCopyWith(Candle value, $Res Function(Candle) then) =
      _$CandleCopyWithImpl<$Res, Candle>;
  @useResult
  $Res call(
      {double close,
      double high,
      double low,
      double open,
      DateTime timestamp,
      double volume});
}

/// @nodoc
class _$CandleCopyWithImpl<$Res, $Val extends Candle>
    implements $CandleCopyWith<$Res> {
  _$CandleCopyWithImpl(this._value, this._then);

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
    Object? timestamp = null,
    Object? volume = null,
  }) {
    return _then(_value.copyWith(
      close: null == close
          ? _value.close
          : close // ignore: cast_nullable_to_non_nullable
              as double,
      high: null == high
          ? _value.high
          : high // ignore: cast_nullable_to_non_nullable
              as double,
      low: null == low
          ? _value.low
          : low // ignore: cast_nullable_to_non_nullable
              as double,
      open: null == open
          ? _value.open
          : open // ignore: cast_nullable_to_non_nullable
              as double,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      volume: null == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CandleCopyWith<$Res> implements $CandleCopyWith<$Res> {
  factory _$$_CandleCopyWith(_$_Candle value, $Res Function(_$_Candle) then) =
      __$$_CandleCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double close,
      double high,
      double low,
      double open,
      DateTime timestamp,
      double volume});
}

/// @nodoc
class __$$_CandleCopyWithImpl<$Res>
    extends _$CandleCopyWithImpl<$Res, _$_Candle>
    implements _$$_CandleCopyWith<$Res> {
  __$$_CandleCopyWithImpl(_$_Candle _value, $Res Function(_$_Candle) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? close = null,
    Object? high = null,
    Object? low = null,
    Object? open = null,
    Object? timestamp = null,
    Object? volume = null,
  }) {
    return _then(_$_Candle(
      null == close
          ? _value.close
          : close // ignore: cast_nullable_to_non_nullable
              as double,
      null == high
          ? _value.high
          : high // ignore: cast_nullable_to_non_nullable
              as double,
      null == low
          ? _value.low
          : low // ignore: cast_nullable_to_non_nullable
              as double,
      null == open
          ? _value.open
          : open // ignore: cast_nullable_to_non_nullable
              as double,
      null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      null == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$_Candle extends _Candle {
  _$_Candle(
      this.close, this.high, this.low, this.open, this.timestamp, this.volume)
      : super._();

  @override
  final double close;
  @override
  final double high;
  @override
  final double low;
  @override
  final double open;
  @override
  final DateTime timestamp;
  @override
  final double volume;

  @override
  String toString() {
    return 'Candle(close: $close, high: $high, low: $low, open: $open, timestamp: $timestamp, volume: $volume)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Candle &&
            (identical(other.close, close) || other.close == close) &&
            (identical(other.high, high) || other.high == high) &&
            (identical(other.low, low) || other.low == low) &&
            (identical(other.open, open) || other.open == open) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.volume, volume) || other.volume == volume));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, close, high, low, open, timestamp, volume);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CandleCopyWith<_$_Candle> get copyWith =>
      __$$_CandleCopyWithImpl<_$_Candle>(this, _$identity);
}

abstract class _Candle extends Candle {
  factory _Candle(
      final double close,
      final double high,
      final double low,
      final double open,
      final DateTime timestamp,
      final double volume) = _$_Candle;
  _Candle._() : super._();

  @override
  double get close;
  @override
  double get high;
  @override
  double get low;
  @override
  double get open;
  @override
  DateTime get timestamp;
  @override
  double get volume;
  @override
  @JsonKey(ignore: true)
  _$$_CandleCopyWith<_$_Candle> get copyWith =>
      throw _privateConstructorUsedError;
}
