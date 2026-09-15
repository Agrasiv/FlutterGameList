import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/api_paginated_response.dart';
import '../../data/models/pagination_state.dart';
import '../../data/models/game_item.dart';
import '../../data/services/api_client.dart';
import '../../presentation/providers/generic_paginated_notifier.dart';

final dioProvider = Provider((ref) => Dio());
final apiClientProvider = Provider((ref) => ApiClient(ref.watch(dioProvider)));

class GamesProvider extends GenericPaginatedNotifier<GameItem> {

  @override
  Future<ApiPaginatedResponse<GameItem>> fetchApi(int page) {
    final client = ref.read(apiClientProvider);
    return client.getPaginatiomGame(page);
  }
}

final gameProvider = AsyncNotifierProvider.autoDispose<
    GamesProvider, PaginationState<GameItem>>(
      () => GamesProvider()
);