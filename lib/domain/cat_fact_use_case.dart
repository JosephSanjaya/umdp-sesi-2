import 'package:umpdsesi2/data/cat_local_datasource.dart';
import 'package:umpdsesi2/data/cat_remote_client.dart';

import '../entities/cat_data.dart';

import 'dart:math';

class CatFactUseCase {
  final CatApiClient apiClient;
  final CatLocalDatasource localDataSource;

  CatFactUseCase({required this.apiClient, required this.localDataSource});

  final List<String> catImageUrls = [
    "https://pixnio.com/free-images/2017/09/26/2017-09-26-07-22-55.jpg",
    "https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_square.jpg",
    "https://static.pexels.com/photos/45201/kitty-cat-kitten-pet-45201.jpeg",
    "http://upload.wikimedia.org/wikipedia/commons/9/9b/Photo_of_a_kitten.jpg",
    "https://cdn.pixabay.com/photo/2017/05/29/15/34/kitten-2354016_1280.jpg",
    "https://tse2.mm.bing.net/th?id=OIP.kUW04gv7eKnBKW769pfqLAHaNK&pid=Api",
    "https://wallup.net/wp-content/uploads/2018/10/06/708179-kittens-kitten-cat-cats-baby-cute-s.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Cat03.jpg/1200px-Cat03.jpg",
    "https://www.nj.com/resizer/mg42jsVYwvbHKUUFQzpw6gyKmBg=/1280x0/smart/advancelocal-adapter-image-uploads.s3.amazonaws.com/image.nj.com/home/njo-media/width2048/img/somerset_impact/photo/sm0212petjpg-7a377c1c93f64d37.jpg",
    "http://3.bp.blogspot.com/-ajn-9ZveGms/Uim4czBNTgI/AAAAAAAAAWo/cbin6JlIv-w/s1600/Black-And-White-Small-Cat-HD-Wallpaper.jpg",
  ];

  List<String> _availableImages = [];

  /// Fetch cat facts with offline-first strategy
  Future<List<CatData>> fetchCatFacts() async {
    await localDataSource.init();

    try {
      // 1. Fetch from local cache
      if (localDataSource.hasCachedCatFacts()) {
        final cachedFacts = localDataSource.getCachedCatFacts();
        _refreshFactsInBackground(); // Attempt to update from API in the background
        return cachedFacts;
      }

      // 2. If no local cache, fetch from API
      final facts = await _fetchFromApiAndCache();
      return facts;
    } catch (e) {
      print("Error fetching cat facts: $e");

      // 3. Fallback: Return local cache if available
      if (localDataSource.hasCachedCatFacts()) {
        return localDataSource.getCachedCatFacts();
      }

      // 4. If all fails, throw an error
      throw Exception("Failed to fetch cat facts and no local data available.");
    }
  }

  /// Fetch from the API and cache the results locally
  Future<List<CatData>> _fetchFromApiAndCache() async {
    final List<CatData> facts = [];

    if (_availableImages.isEmpty) {
      _availableImages = List.from(catImageUrls);
    }

    for (int i = 0; i < 10; i++) {
      final catFact = await apiClient.getCatFact();
      final random = Random();
      final randomIndex = random.nextInt(_availableImages.length);
      final imageUrl = _availableImages.removeAt(randomIndex);

      facts.add(CatData(data: catFact.data, imageUrl: imageUrl));
    }

    await localDataSource.cacheCatFacts(facts);
    return facts;
  }

  /// Refresh facts from the API in the background without affecting the user's current data
  Future<void> _refreshFactsInBackground() async {
    try {
      await _fetchFromApiAndCache();
      print("Facts refreshed from API in the background.");
    } catch (e) {
      print("Failed to refresh facts in the background: $e");
    }
  }
}
