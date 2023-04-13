import '../../data/model/market_cap_percentage.dart';
import '../../domain/entity/market_cap_percentage.dart';
import '../factory.dart';

class MarketCapPercentageFromDtoFactory
    implements Factory<MarketCapPercentage, MarketCapPercentageDto> {
  @override
  MarketCapPercentage create(MarketCapPercentageDto param) =>
      MarketCapPercentage(
        param.coinSymbol,
        param.percentage,
      );
}
