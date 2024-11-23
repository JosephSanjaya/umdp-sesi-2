import 'package:get/get.dart';
import '../../domain/cat_fact_use_case.dart';
import '../../entities/cat_data.dart';
import 'home_state.dart';

class HomeViewModel extends GetxController {
  final CatFactUseCase useCase;
  final _state = const HomeState().obs;

  HomeViewModel(this.useCase);

  HomeState get state => _state.value;

  @override
  void onInit() {
    super.onInit();
    fetchCatFacts(); // Fetch multiple cat facts on initialization
  }

  Future<void> fetchCatFacts() async {
    try {
      final facts = await useCase.fetchCatFacts();
      _state.value = _state.value.copyWith(catFacts: facts);
    } catch (e) {
      print("Error fetching cat facts: $e");
    }
  }
}