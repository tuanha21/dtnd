class SecEvent {
  String? tradeDate;
  String? content;
  String? container;
  String? filePath;
  String? attach;
  String? source;
  String? title;

  DateTime? get dateTime {
    if (tradeDate == null) {
      return null;
    }
    return DateTime.tryParse(tradeDate!);
  }

  String get link =>
      'https://files.algoplatform.vn/getfile.aspx?path=$filePath&name=$attach&time=${DateTime.now().millisecondsSinceEpoch}';

  SecEvent(
      {this.tradeDate,
      this.content,
      this.container,
      this.filePath,
      this.attach,
      this.source,
      this.title});

  SecEvent.fromJson(Map<String, dynamic> json) {
    tradeDate = json['tradeDate'];
    content = json['content'];
    container = json['container'];
    filePath = json['filePath'];
    attach = json['attach'];
    source = json['source'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tradeDate'] = tradeDate;
    data['content'] = content;
    data['container'] = container;
    data['filePath'] = filePath;
    data['attach'] = attach;
    data['source'] = source;
    data['title'] = title;
    return data;
  }
}
