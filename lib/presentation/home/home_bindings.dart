import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:umpdsesi2/data/cat_local_datasource.dart';
import 'package:umpdsesi2/data/cat_remote_client.dart';
import 'package:umpdsesi2/domain/cat_fact_use_case.dart';
import 'package:umpdsesi2/presentation/home/home_viewmodel.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Dio>(() {
      return Dio();
    }, fenix: true);
    Get.lazyPut(() => CatApiClient(Get.find()));
    Get.lazyPut(() => CatLocalDatasource());
    Get.lazyPut(() =>
        CatFactUseCase(apiClient: Get.find(), localDataSource: Get.find()));
    Get.lazyPut(() => HomeViewModel(Get.find()));
  }
}
