import '../../data/model/market_cap_percentage.dart';
import '../factory.dart';

class MarketCapPercentageDtoFromJsonFactory
    implements Factory<MarketCapPercentageDto, Map<String, dynamic>> {
  @override
  MarketCapPercentageDto create(Map<String, dynamic> param) =>
      MarketCapPercentageDto(
        param['coin_symbol'] as String?,
        param['percentage'] as num?,
      );
}
