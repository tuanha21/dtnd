import 'dart:convert';

enum RequestType { string, cursor }

extension RequestTypeX on RequestType {}

class RequestModel {
  String? group;
  String? user;
  String? session;
  RequestDataModel? data;

  RequestModel({this.group, this.user, this.session, this.data});

  RequestModel.fromJson(Map<String, dynamic> json) {
    group = json['group'];
    user = json['user'];
    session = json['session'];
    data =
        json['data'] != null ? RequestDataModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['group'] = group;
    data['user'] = user;
    data['session'] = session ?? "";
    data['channel'] = "M";
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  @override
  String toString() => json.encode(toJson());
}

class RequestDataModel {
  RequestType? type;
  String? cmd;
  String? p1;
  String? p2;
  String? p3;
  String? p4;

  RequestDataModel({this.type, this.cmd, this.p1, this.p2, this.p3, this.p4});

  RequestDataModel.fromJson(Map<String, dynamic> json) {
    type = RequestTypeHelper.fromString(json['type']);
    cmd = json['cmd'];
    p1 = json['p1'];
    p2 = json['p2'];
    p3 = json['p3'];
    p4 = json['p4'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type?.name ?? "string";
    data['cmd'] = cmd;
    data['p1'] = p1;
    data['p2'] = p2;
    data['p3'] = p3;
    data['p4'] = p4;
    return data;
  }
}

class RequestTypeHelper {
  static RequestType fromString(String string) {
    switch (string.toLowerCase()) {
      case "cursor":
        return RequestType.cursor;
      default:
        return RequestType.string;
    }
  }
}
