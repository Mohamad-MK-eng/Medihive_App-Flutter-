class ApiResult<T> {
  final T? data;
  final T? error;
  ApiResult.success(this.data) : error = null;
  ApiResult.failure(this.error) : data = null;

  bool get isSuccess => data != null;
}
