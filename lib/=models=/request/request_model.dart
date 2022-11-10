class RequestModel {
  String? group;
  String? user;
  String? session;
  String? channel;
  RequestData? data;

  RequestModel({this.group, this.user, this.session, this.channel, this.data});

  RequestModel.fromJson(Map<String, dynamic> json) {
    group = json['group'];
    user = json['user'];
    session = json['session'];
    channel = json['channel'];
    data = json['data'] != null ? RequestData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['group'] = group;
    data['user'] = user;
    data['session'] = session;
    data['channel'] = channel;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class RequestData {
  String? type;
  String? cmd;
  String? p1;
  String? p2;
  String? p3;
  String? p4;

  RequestData({this.type, this.cmd, this.p1, this.p2, this.p3, this.p4});

  RequestData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    cmd = json['cmd'];
    p1 = json['p1'];
    p2 = json['p2'];
    p3 = json['p3'];
    p4 = json['p4'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['cmd'] = cmd;
    data['p1'] = p1;
    data['p2'] = p2;
    data['p3'] = p3;
    data['p4'] = p4;
    return data;
  }
}
