extension ListExtensions<T> on List<T> {
  List<T> extend(List<T>? other) {
    return [...this, ...?other];
  }
}
