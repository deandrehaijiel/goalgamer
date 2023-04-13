// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'candles_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CandlesPayload _$$_CandlesPayloadFromJson(Map<String, dynamic> json) =>
    _$_CandlesPayload(
      (json['c'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          [],
      (json['h'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          [],
      (json['l'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          [],
      (json['o'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          [],
      (json['t'] as List<dynamic>?)?.map((e) => e as int).toList() ?? [],
      (json['v'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          [],
    );

Map<String, dynamic> _$$_CandlesPayloadToJson(_$_CandlesPayload instance) =>
    <String, dynamic>{
      'c': instance.close,
      'h': instance.high,
      'l': instance.low,
      'o': instance.open,
      't': instance.unixTimestamp,
      'v': instance.volume,
    };