class SignalType {
  late final String signalCode;
  late final String signalDetail;
  late final num sort;
  SignalType.fromJson(Map<String, dynamic> json) {
    signalCode = json["SIGNAL_CODE"];
    signalDetail = json["SIGNAL_DETAIL"];
    sort = json["C_SORT"];
  }
}
