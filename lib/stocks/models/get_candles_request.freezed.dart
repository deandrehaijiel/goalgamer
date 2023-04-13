// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_candles_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GetCandlesRequest _$GetCandlesRequestFromJson(Map<String, dynamic> json) {
  return _GetCandlesRequest.fromJson(json);
}

/// @nodoc
mixin _$GetCandlesRequest {
  @JsonKey(toJson: ResolutionExtensions.toJson)
  Resolution get resolution => throw _privateConstructorUsedError;
  @JsonKey(toJson: DateTimeHelper.toUnixSeconds)
  DateTime get to => throw _privateConstructorUsedError;
  @JsonKey(toJson: DateTimeHelper.toUnixSeconds)
  DateTime get from => throw _privateConstructorUsedError;
  String get symbol => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetCandlesRequestCopyWith<GetCandlesRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetCandlesRequestCopyWith<$Res> {
  factory $GetCandlesRequestCopyWith(
          GetCandlesRequest value, $Res Function(GetCandlesRequest) then) =
      _$GetCandlesRequestCopyWithImpl<$Res, GetCandlesRequest>;
  @useResult
  $Res call(
      {@JsonKey(toJson: ResolutionExtensions.toJson) Resolution resolution,
      @JsonKey(toJson: DateTimeHelper.toUnixSeconds) DateTime to,
      @JsonKey(toJson: DateTimeHelper.toUnixSeconds) DateTime from,
      String symbol});
}

/// @nodoc
class _$GetCandlesRequestCopyWithImpl<$Res, $Val extends GetCandlesRequest>
    implements $GetCandlesRequestCopyWith<$Res> {
  _$GetCandlesRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resolution = null,
    Object? to = null,
    Object? from = null,
    Object? symbol = null,
  }) {
    return _then(_value.copyWith(
      resolution: null == resolution
          ? _value.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as Resolution,
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as DateTime,
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as DateTime,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GetCandlesRequestCopyWith<$Res>
    implements $GetCandlesRequestCopyWith<$Res> {
  factory _$$_GetCandlesRequestCopyWith(_$_GetCandlesRequest value,
          $Res Function(_$_GetCandlesRequest) then) =
      __$$_GetCandlesRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(toJson: ResolutionExtensions.toJson) Resolution resolution,
      @JsonKey(toJson: DateTimeHelper.toUnixSeconds) DateTime to,
      @JsonKey(toJson: DateTimeHelper.toUnixSeconds) DateTime from,
      String symbol});
}

/// @nodoc
class __$$_GetCandlesRequestCopyWithImpl<$Res>
    extends _$GetCandlesRequestCopyWithImpl<$Res, _$_GetCandlesRequest>
    implements _$$_GetCandlesRequestCopyWith<$Res> {
  __$$_GetCandlesRequestCopyWithImpl(
      _$_GetCandlesRequest _value, $Res Function(_$_GetCandlesRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resolution = null,
    Object? to = null,
    Object? from = null,
    Object? symbol = null,
  }) {
    return _then(_$_GetCandlesRequest(
      null == resolution
          ? _value.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as Resolution,
      null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as DateTime,
      null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as DateTime,
      null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_GetCandlesRequest extends _GetCandlesRequest {
  _$_GetCandlesRequest(
      @JsonKey(toJson: ResolutionExtensions.toJson) this.resolution,
      @JsonKey(toJson: DateTimeHelper.toUnixSeconds) this.to,
      @JsonKey(toJson: DateTimeHelper.toUnixSeconds) this.from,
      this.symbol)
      : super._();

  factory _$_GetCandlesRequest.fromJson(Map<String, dynamic> json) =>
      _$$_GetCandlesRequestFromJson(json);

  @override
  @JsonKey(toJson: ResolutionExtensions.toJson)
  final Resolution resolution;
  @override
  @JsonKey(toJson: DateTimeHelper.toUnixSeconds)
  final DateTime to;
  @override
  @JsonKey(toJson: DateTimeHelper.toUnixSeconds)
  final DateTime from;
  @override
  final String symbol;

  @override
  String toString() {
    return 'GetCandlesRequest(resolution: $resolution, to: $to, from: $from, symbol: $symbol)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetCandlesRequest &&
            (identical(other.resolution, resolution) ||
                other.resolution == resolution) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.symbol, symbol) || other.symbol == symbol));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, resolution, to, from, symbol);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GetCandlesRequestCopyWith<_$_GetCandlesRequest> get copyWith =>
      __$$_GetCandlesRequestCopyWithImpl<_$_GetCandlesRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GetCandlesRequestToJson(
      this,
    );
  }
}

abstract class _GetCandlesRequest extends GetCandlesRequest {
  factory _GetCandlesRequest(
      @JsonKey(toJson: ResolutionExtensions.toJson) final Resolution resolution,
      @JsonKey(toJson: DateTimeHelper.toUnixSeconds) final DateTime to,
      @JsonKey(toJson: DateTimeHelper.toUnixSeconds) final DateTime from,
      final String symbol) = _$_GetCandlesRequest;
  _GetCandlesRequest._() : super._();

  factory _GetCandlesRequest.fromJson(Map<String, dynamic> json) =
      _$_GetCandlesRequest.fromJson;

  @override
  @JsonKey(toJson: ResolutionExtensions.toJson)
  Resolution get resolution;
  @override
  @JsonKey(toJson: DateTimeHelper.toUnixSeconds)
  DateTime get to;
  @override
  @JsonKey(toJson: DateTimeHelper.toUnixSeconds)
  DateTime get from;
  @override
  String get symbol;
  @override
  @JsonKey(ignore: true)
  _$$_GetCandlesRequestCopyWith<_$_GetCandlesRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
