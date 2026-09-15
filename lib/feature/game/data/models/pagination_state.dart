class PaginationState<T> {
  final List<T> items;
  final int currentPage;
  final bool hasMore;
  final bool isLoadingMore;

  const PaginationState({
    required this.items,
    this.currentPage = 1,
    this.hasMore = true,
    this.isLoadingMore = false
  });

  PaginationState<T> copyWith({
    List<T>? items,
    int? currentPage,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return PaginationState<T>(
        items: items ?? this.items,
        currentPage: currentPage ?? this.currentPage,
        hasMore: hasMore ?? this.hasMore,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore
    );
  }
}
