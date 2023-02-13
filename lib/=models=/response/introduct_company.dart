class CompanyIntroductionResponse {
  int? status;
  dynamic message;
  CompanyIntroduction? data;

  CompanyIntroductionResponse({this.status, this.message, this.data});

  CompanyIntroductionResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? CompanyIntroduction.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class CompanyIntroduction {
  String? profile;

  CompanyIntroduction({this.profile});

  CompanyIntroduction.fromJson(Map<String, dynamic> json) {
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profile'] = profile;
    return data;
  }
}
