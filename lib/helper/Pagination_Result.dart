class PaginatedResult<T> {
  final List<T> items;
  final int last_page;
  PaginatedResult({required this.items, required this.last_page});
}
