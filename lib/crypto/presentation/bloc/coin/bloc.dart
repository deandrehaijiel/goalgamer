import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../backbone/bloc_status.dart';
import '../../../domain/entity/coin.dart';
import '../../../domain/usecase/get_market_coins.dart';

part 'bloc.freezed.dart';
part 'event.dart';
part 'state.dart';

class CoinBloc extends Bloc<CoinEvent, CoinState> {
  final GetMarketCoinsUseCase _getMarketCoinsUseCase;

  CoinBloc(this._getMarketCoinsUseCase)
      : super(const CoinState(BlocStatus.Loading, <Coin>[])) {
    on<GetMarketCoinsEvent>(
      (GetMarketCoinsEvent event, Emitter<CoinState> emit) async {
        await event.when(
          getMarketCoins: (String currency, String order, int pageNumber,
                  int perPage, String sparkline) =>
              _getMarketCoins(
                  emit, currency, order, pageNumber, perPage, sparkline),
        );
      },
    );
  }
  Future<void> _getMarketCoins(Emitter<CoinState> emit, String currency,
      String order, int pageNumber, int perPage, String sparkline) async {
    emit(_loadingState());
    emit(await _getMarketCoinsUseCase(
            currency, order, pageNumber, perPage, sparkline)
        .then((List<Coin> coin) => CoinState(BlocStatus.Loaded, coin))
        .catchError(_onError));
  }

  CoinState _loadingState() => CoinState(BlocStatus.Loading, state.coins);

  Future<CoinState> _onError(Object error) async =>
      CoinState(BlocStatus.Error, state.coins, error: error);
}
