import '../entity/global_data.dart';

abstract class GlobalDataService {
  Future<GlobalData> getGlobalData();
}
