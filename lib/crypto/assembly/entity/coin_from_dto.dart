import '../../data/model/coin.dart';
import '../../domain/entity/coin.dart';
import '../factory.dart';

class CoinFromDtoFactory implements Factory<Coin, CoinDto> {
  @override
  Coin create(CoinDto param) => Coin(
        param.id,
        param.symbol,
        param.name,
        param.image,
        param.currentPrice,
        param.marketCap,
        param.priceChangePercentage,
        param.sparklineIn7d,
      );
}
