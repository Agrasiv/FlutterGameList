import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:movie_list_app/feature/game/data/models/api_paginated_response.dart';
import 'package:movie_list_app/feature/game/data/models/game_item.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "https://jsonfakery.com/")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("games/paginated")
  Future<ApiPaginatedResponse<GameItem>> getPaginatiomGame(
    @Query("page") int page,
  );
}
