import 'package:get/get.dart';
import 'package:umpdsesi2/domain/cat_fact_use_case.dart';
import 'package:workmanager/workmanager.dart';

class WorkmanagerInitializer {
  static void initialize() {
    // Initialize Workmanager
    Workmanager().initialize(_catFactJob, isInDebugMode: true);

    // Register periodic task
    Workmanager().registerPeriodicTask(
      "catFactBackgroundTask",
      "fetchCatFacts",
      frequency: Duration(minutes: 15), // Minimum interval for periodic tasks
    );

    print("Workmanager initialized and periodic task registered.");
  }

  static void _catFactJob() {
    Workmanager().executeTask((task, inputData) async {
      if (task == "fetchCatFacts") {
        try {
          final CatFactUseCase useCase = Get.find();
          await useCase.fetchCatFacts();
          print("Background task: Data fetched and cached.");
          return Future.value(true);
        } catch (e) {
          print("Background task failed: $e");
          return Future.value(false);
        }
      }
      return Future.value(false);
    });
  }
}
