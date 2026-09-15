import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/api_paginated_response.dart';
import '../../data/models/pagination_state.dart';

abstract class GenericPaginatedNotifier<T> extends AutoDisposeAsyncNotifier<PaginationState<T>> {

  Future<ApiPaginatedResponse<T>> fetchApi(int page);

  @override
  Future<PaginationState<T>> build() async {
    final response = await fetchApi(1);
    return PaginationState<T>(
      items: response.data,
      currentPage: response.currentPage,
      isLoadingMore: false,
      hasMore: response.data.isNotEmpty
    );
  }

  Future<void> fetchNextPage() async {
    final currentState = state.valueOrNull;
    if (currentState == null || currentState.isLoadingMore || !currentState.hasMore) {
      return;
    }

    state = AsyncData(currentState.copyWith(isLoadingMore: true));

    try {
      final nextPage = currentState.currentPage + 1;
      final response = await fetchApi(nextPage);

      state = AsyncData(
        currentState.copyWith(
          items: [...currentState.items, ...response.data],
          currentPage: nextPage,
          hasMore: response.data.isNotEmpty,
          isLoadingMore: false
        ),
      );
    } catch(e, st) {
      state = AsyncData(currentState.copyWith(isLoadingMore: false));
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final response = await fetchApi(1);
      return PaginationState<T>(
          items: response.data,
          currentPage: response.currentPage,
          isLoadingMore: false,
          hasMore: response.data.isNotEmpty
      );
    });
  }

}