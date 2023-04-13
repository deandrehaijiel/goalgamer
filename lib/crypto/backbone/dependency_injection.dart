
import 'package:get_it/get_it.dart';

import '../assembly/entity/coin_from_dto.dart';
import '../assembly/entity/global_data_from_dto.dart';
import '../assembly/entity/market_cap_percentage.dart';
import '../assembly/factory.dart';
import '../assembly/model/coin_dto_from_json.dart';
import '../assembly/model/global_data_dto_from_json.dart';
import '../assembly/model/market_cap_percentage.dart';
import '../data/gateway/rest.dart';
import '../data/gateway/settings.dart';
import '../data/model/coin.dart';
import '../data/model/global_data.dart';
import '../data/model/market_cap_percentage.dart';
import '../data/service/hive_settings.dart';
import '../data/service/rest_coins.dart';
import '../data/service/rest_global_data.dart';
import '../domain/entity/coin.dart';
import '../domain/entity/global_data.dart';
import '../domain/entity/market_cap_percentage.dart';
import '../domain/service/coin.dart';
import '../domain/service/global_data.dart';
import '../domain/service/settings.dart';
import '../domain/usecase/get_fiat_currency.dart';
import '../domain/usecase/get_global_data.dart';
import '../domain/usecase/get_market_coins.dart';
import '../domain/usecase/get_theme.dart';
import '../domain/usecase/select_fiat_currency.dart';
import '../domain/usecase/select_theme.dart';
import '../presentation/bloc/coin/bloc.dart';
import '../presentation/bloc/global_data/bloc.dart';
import '../presentation/bloc/settings/bloc.dart';

final GetIt sl = GetIt.instance;

void init() {
  //From Dto Factory
  sl.registerLazySingleton<Factory<Coin, CoinDto>>(() => CoinFromDtoFactory());
  sl.registerLazySingleton<Factory<GlobalData, GlobalDataDto>>(
      () => GlobalDataFromDtoFactory(
            sl.get(),
          ));
  sl.registerLazySingleton<
          Factory<MarketCapPercentage, MarketCapPercentageDto>>(
      () => MarketCapPercentageFromDtoFactory());

  //From Json Factory
  sl.registerLazySingleton<Factory<CoinDto, Map<String, dynamic>>>(
      () => CoinDtoFromJsonFactory());
  sl.registerLazySingleton<Factory<GlobalDataDto, Map<String, dynamic>>>(
      () => GlobalDataDtoFromJsonFactory());
  sl.registerLazySingleton<
          Factory<MarketCapPercentageDto, Map<String, dynamic>>>(
      () => MarketCapPercentageDtoFromJsonFactory());
  //Gateway
  sl.registerLazySingleton<RestGateway>(() => RestGateway(
        sl.get(),
        sl.get(),
      ));
  sl.registerLazySingleton<SettingsGateway>(() => SettingsGateway());

  //Service
  sl.registerLazySingleton<CoinService>(
      () => RestCoinService(sl.get(), sl.get()));
  sl.registerLazySingleton<GlobalDataService>(
      () => RestGlobalDataService(sl.get(), sl.get()));
  sl.registerLazySingleton<SettingsService>(
      () => HiveSettingsSerivce(sl.get()));
      
  //UseCase
  sl.registerLazySingleton<GetMarketCoinsUseCase>(
      () => RestGetMarketCoinsUseCase(sl.get()));
  sl.registerLazySingleton<GetGlobalDataUseCase>(
      () => RestGetGlobalDataUseCase(sl.get()));
  sl.registerLazySingleton<GetFiatCurrencyUseCase>(
      () => RestGetFiatCurrencyUseCase(sl.get()));
  sl.registerLazySingleton<SelectFiatCurrencyUseCase>(
      () => RestSelectFiatCurrencyUseCase(sl.get()));
  sl.registerLazySingleton<GetThemeUseCase>(
      () => RestGetThemeUseCase(sl.get()));
  sl.registerLazySingleton<SelectThemeUseCase>(
      () => RestSelectThemeUseCase(sl.get()));
      
  //Bloc
  sl.registerLazySingleton<CoinBloc>(() => CoinBloc(sl.get()));
  sl.registerLazySingleton<GlobalDataBloc>(() => GlobalDataBloc(sl.get()));
  sl.registerLazySingleton<SettingsBloc>(
      () => SettingsBloc(sl.get(), sl.get(), sl.get(), sl.get()));
}
