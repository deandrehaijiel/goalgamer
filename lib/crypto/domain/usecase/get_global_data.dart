import '../entity/global_data.dart';
import '../service/global_data.dart';

abstract class GetGlobalDataUseCase {
  Future<GlobalData> call();
}

class RestGetGlobalDataUseCase implements GetGlobalDataUseCase {
  final GlobalDataService _service;

  RestGetGlobalDataUseCase(this._service);

  @override
  Future<GlobalData> call() => _service.getGlobalData();
}
