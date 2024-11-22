import 'package:umpdsesi2/data/cat_remote_client.dart';

import '../entities/cat_data.dart';

class CatFactUseCase {
  final CatApiClient apiClient;

  CatFactUseCase(this.apiClient);

  Future<CatData> getCatFact() async {
    try {
      return await apiClient.getCatFact();
    } catch (e) {
      // Log or handle errors as needed
      throw Exception("Failed to fetch cat fact: $e");
    }
  }
}
