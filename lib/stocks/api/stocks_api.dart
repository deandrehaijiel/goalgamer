import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class StocksApi {
  final Dio _dio;

  StocksApi(this._dio);

  static Dio buildDefaultHttpClient(String apiKey) {
    final dio = Dio();
    dio.options.baseUrl = "https://finnhub.io/api";
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.queryParameters.addAll({
          "token": apiKey,
        });

        return handler.next(options);
      },
    ));

    return dio;
  }

  Future<List<Candle>> getCandles(GetCandlesRequest request) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        "/v1/stock/candle",
        queryParameters: request.toJson(),
      );

      final candlesPayload = CandlesPayload.fromJson(response.data!);
      return candlesPayload.toCandles();
    } catch (e, s) {
      debugPrint("$e\n$s");
      throw StocksApiException("An unknown error occurred");
    }
  }
}

class StocksApiException {
  final String message;

  StocksApiException(this.message);
}
