// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../api/api.dart';
import '../helper/helper.dart';

part 'get_candles_request.freezed.dart';
part 'get_candles_request.g.dart';

@freezed
class GetCandlesRequest with _$GetCandlesRequest {
  const GetCandlesRequest._();

  @JsonSerializable(explicitToJson: true)
  factory GetCandlesRequest(
    @JsonKey(toJson: ResolutionExtensions.toJson) Resolution resolution,
    @JsonKey(toJson: DateTimeHelper.toUnixSeconds) DateTime to,
    @JsonKey(toJson: DateTimeHelper.toUnixSeconds) DateTime from,
    String symbol,
  ) = _GetCandlesRequest;

  // I don't actually need a fromJson here but it seems like
  // freezed only makes me a toJson if this exists
  factory GetCandlesRequest.fromJson(Map<String, dynamic> json) =>
      _$GetCandlesRequestFromJson(json);
}
