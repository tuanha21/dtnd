class Pair<T, U> {
  final T first;
  U second;

  Pair(this.first, this.second);

  @override
  operator ==(Object? other) {
    return other is Pair && other.first == this.first;
  }

  @override
  int get hashCode => first.hashCode ^ second.hashCode;
}
