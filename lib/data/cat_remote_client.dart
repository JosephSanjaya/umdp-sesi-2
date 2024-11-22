
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../entities/cat_data.dart';

part 'cat_remote_client.g.dart';

@RestApi(baseUrl: "https://meowfacts.herokuapp.com/")
abstract class CatApiClient {
  factory CatApiClient(Dio dio, {String baseUrl}) = _CatApiClient;

  @GET("/")
  Future<CatData> getCatFact();
}
