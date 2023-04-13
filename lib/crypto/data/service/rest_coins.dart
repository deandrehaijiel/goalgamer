import '../../assembly/factory.dart';
import '../../domain/entity/coin.dart';
import '../../domain/service/coin.dart';
import '../gateway/rest.dart';
import '../model/coin.dart';

class RestCoinService implements CoinService {
  final RestGateway _gateway;
  final Factory<Coin, CoinDto> _factory;
  RestCoinService(this._gateway, this._factory);

  @override
  Future<List<Coin>> getMarketsCoins(String currency, String order,
      int pageNumber, int perPage, String sparkline) async {
    final List<CoinDto> dtoList = await _gateway.getMarketsCoins(
      currency,
      order,
      pageNumber,
      perPage,
      sparkline,
    );
    return dtoList.map((CoinDto dto) => _factory.create(dto)).toList();
  }
}
