import '../entity/coin.dart';
import '../service/coin.dart';

abstract class GetMarketCoinsUseCase {
  Future<List<Coin>> call(
    String currency,
    String order,
    int pageNumber,
    int perPage,
    String sparkline,
  );
}

class RestGetMarketCoinsUseCase implements GetMarketCoinsUseCase {
  final CoinService _service;

  RestGetMarketCoinsUseCase(this._service);

  @override
  Future<List<Coin>> call(String currency, String order, int pageNumber,
          int perPage, String sparkline) =>
      _service.getMarketsCoins(currency, order, pageNumber, perPage, sparkline);
}
