

import '../../assembly/factory.dart';
import '../../domain/entity/global_data.dart';
import '../../domain/service/global_data.dart';
import '../gateway/rest.dart';
import '../model/global_data.dart';

class RestGlobalDataService implements GlobalDataService {
  final RestGateway _gateway;
  final Factory<GlobalData, GlobalDataDto> _factory;
  RestGlobalDataService(this._gateway, this._factory);

  @override
  Future<GlobalData> getGlobalData() async =>
      _factory.create(await _gateway.getGlobalData());
}
