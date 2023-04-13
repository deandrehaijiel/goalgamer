

import '../../data/model/global_data.dart';
import '../../data/model/market_cap_percentage.dart';
import '../../domain/entity/global_data.dart';
import '../../domain/entity/market_cap_percentage.dart';
import '../factory.dart';

class GlobalDataFromDtoFactory implements Factory<GlobalData, GlobalDataDto> {
  final Factory<MarketCapPercentage, MarketCapPercentageDto>
      _marketCapPercentageFactory;
  GlobalDataFromDtoFactory(this._marketCapPercentageFactory);
  @override
  GlobalData create(GlobalDataDto param) => GlobalData(
        param.activeCryptocurrencies,
        param.markets,
        param.marketCapPercentage
            .map((MarketCapPercentageDto dto) =>
                _marketCapPercentageFactory.create(dto))
            .toList(),
      );
}
