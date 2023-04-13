// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'get_candles_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GetCandlesRequest _$$_GetCandlesRequestFromJson(Map<String, dynamic> json) =>
    _$_GetCandlesRequest(
      $enumDecode(_$ResolutionEnumMap, json['resolution']),
      DateTime.parse(json['to'] as String),
      DateTime.parse(json['from'] as String),
      json['symbol'] as String,
    );

Map<String, dynamic> _$$_GetCandlesRequestToJson(
        _$_GetCandlesRequest instance) =>
    <String, dynamic>{
      'resolution': ResolutionExtensions.toJson(instance.resolution),
      'to': DateTimeHelper.toUnixSeconds(instance.to),
      'from': DateTimeHelper.toUnixSeconds(instance.from),
      'symbol': instance.symbol,
    };

const _$ResolutionEnumMap = {
  Resolution.oneMinute: 'oneMinute',
  Resolution.fiveMinutes: 'fiveMinutes',
  Resolution.fifteenMinutes: 'fifteenMinutes',
  Resolution.thirtyMinutes: 'thirtyMinutes',
  Resolution.hour: 'hour',
  Resolution.day: 'day',
  Resolution.month: 'month',
};