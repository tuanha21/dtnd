mixin InvestEffect {
  List<num> calculateEffect(List<num> rs) {
    final List<num> effectPerDay = <num>[];
    for (var i = 0; i < rs.length; i++) {
      effectPerDay.add(_effectOfDay(rs.sublist(0, i)));
    }
    return effectPerDay;
  }

  num _effectOfDay(List<num> rs) {
    num effect = 1;
    for (var r in rs) {
      effect *= (1 + r);
    }

    effect -= 1;
    return effect;
  }
}
