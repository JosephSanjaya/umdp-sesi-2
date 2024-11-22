import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:umpdsesi2/data/cat_remote_client.dart';
import 'package:umpdsesi2/domain/CatFactUseCase.dart';
import 'package:umpdsesi2/presentation/home/home_viewmodel.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Dio>(() {
      return Dio();
    }, fenix: true);
    Get.lazyPut<CatApiClient>(() => CatApiClient(Get.find()));
    Get.lazyPut(() => CatFactUseCase(Get.find()));
    Get.lazyPut(() => HomeViewModel(Get.find()));
  }
}
