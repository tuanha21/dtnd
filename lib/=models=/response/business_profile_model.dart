class BusinnessProfileModel {
  late final String profile;
  late final String profileEn;

  BusinnessProfileModel({required this.profile, required this.profileEn});

  BusinnessProfileModel.fromJson(Map<String, dynamic> json) {
    profile = json['profile'] ?? "";
    profileEn = json['profileEn'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profile'] = profile;
    data['profileEn'] = profileEn;
    return data;
  }
}
