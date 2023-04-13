import '../../domain/service/settings.dart';
import '../gateway/settings.dart';

class HiveSettingsSerivce implements SettingsService {
  final SettingsGateway _gateway;
  HiveSettingsSerivce(this._gateway);

  @override
  Future<String> getFiatCurrency() => _gateway.getFiatCurrency();

  @override
  Future<String> selectFiatCurrency(String fiatCurrency) =>
      _gateway.selectFiatCurrency(fiatCurrency);

  @override
  Future<String> getTheme() => _gateway.getTheme();

  @override
  Future<String> selectTheme(String themeType) =>
      _gateway.selectTheme(themeType);
}
