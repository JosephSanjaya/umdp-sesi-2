import 'package:get/get.dart';
import 'package:umpdsesi2/home/home_viewmodel.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeViewModel());
  }
}
