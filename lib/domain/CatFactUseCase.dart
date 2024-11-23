import 'package:umpdsesi2/data/cat_remote_client.dart';

import '../entities/cat_data.dart';

import 'dart:math';

class CatFactUseCase {
  final CatApiClient apiClient;

  CatFactUseCase(this.apiClient);

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

  // To ensure unique images per fetch, use a temporary list
  List<String> _availableImages = [];

  Future<CatData> getCatFact() async {
    try {
      // Ensure that the temporary list is refreshed when empty
      if (_availableImages.isEmpty) {
        _availableImages = List.from(catImageUrls);
      }

      // Fetch a cat fact from the API
      final catFact = await apiClient.getCatFact();

      // Assign a unique random image
      final random = Random();
      final randomIndex = random.nextInt(_availableImages.length);
      final imageUrl = _availableImages.removeAt(randomIndex);

      // Map the fact with the image URL and return
      return CatData(
        data: catFact.data,
        imageUrl: imageUrl,
      );
    } catch (e) {
      // Log or handle errors as needed
      throw Exception("Failed to fetch cat fact: $e");
    }
  }
}
