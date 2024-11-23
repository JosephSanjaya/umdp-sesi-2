import '../entities/cat_data.dart';

import 'package:hive/hive.dart';

class CatLocalDatasource {
  static const _boxName = 'catFacts';
  Box<CatData>? _box;

  CatLocalDatasource();

  /// Initialize the Hive box
  Future<void> init() async {
    if (!Hive.isBoxOpen(_boxName)) {
      _box = await Hive.openBox<CatData>(_boxName);
    } else {
      _box = Hive.box<CatData>(_boxName);
    }
  }

  /// Cache cat facts into the local Hive box
  Future<void> cacheCatFacts(List<CatData> facts) async {
    if (_box == null) {
      throw Exception("Hive box is not initialized. Call init() first.");
    }

    await _box!.clear(); // Clear old data
    await _box!.addAll(facts); // Add new facts
  }

  /// Retrieve cached cat facts from the local Hive box
  List<CatData> getCachedCatFacts() {
    if (_box == null) {
      throw Exception("Hive box is not initialized. Call init() first.");
    }

    return _box!.values.toList();
  }

  /// Check if there are cached cat facts
  bool hasCachedCatFacts() {
    if (_box == null) {
      throw Exception("Hive box is not initialized. Call init() first.");
    }

    return _box!.isNotEmpty;
  }
}