import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/api.dart';
import '../models/models.dart';
import 'state.dart';

class StocksAppStateCubit extends Cubit<AppState> {
  final StocksApi _stocksApi;

  StocksAppStateCubit(this._stocksApi) : super(AppState.initial());

  Future<List<Candle>?> loadCandles(
    String symbol,
    DateTime from,
    DateTime to,
  ) async {
    emit(state.copyWith(isLoading: true, hasError: false));

    // Find the first resolution which results in less than 100 candles
    final resolution = Resolution.values.firstWhere(
      (r) {
        final ms = to.millisecondsSinceEpoch - from.millisecondsSinceEpoch;
        final resultingCandles = ms / r.duration.inMilliseconds;
        return resultingCandles < 100;
      },
      orElse: () => Resolution.month,
    );

    try {
      final request = GetCandlesRequest(resolution, to, from, symbol);
      emit(state.copyWith(recentQuery: request));

      final candles = await _stocksApi.getCandles(request);

      emit(state.copyWith(
        isLoading: false,
        candles: candles,
        currentSymbol: symbol,
        errorMessage:
            candles.isEmpty ? "No data could be found for your request" : null,
        hasError: candles.isEmpty,
      ));

      return candles;
    } on StocksApiException catch (e) {
      emit(state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: e.message,
      ));
    }
    return null;
  }

  Future<void> fetchCandles(GetCandlesRequest request) async {
    emit(state.copyWith(isLoading: true));

    try {
      final candles = await _stocksApi.getCandles(request);
      emit(state.copyWith(candles: candles, recentQuery: request));
    } on StocksApiException catch (e) {
      emit(state.copyWith(hasError: true, errorMessage: e.message));
    }

    emit(state.copyWith(isLoading: false));
  }
}
