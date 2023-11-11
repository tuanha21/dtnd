extension NullableExt<T> on T? {
  void let(Function(T it) callback) {
    if (this != null) {
      callback(this as T);
    }
  }
}
