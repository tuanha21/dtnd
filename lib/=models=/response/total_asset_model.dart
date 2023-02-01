class TotalAsset {
  num? totalNav;
  num? totalCash;
  num? totalEnquity;
  num? vmEnquity;
  num? vmEnquityPer;
  List<ListAssets>? listAssets;

  TotalAsset(
      {this.totalNav,
      this.totalCash,
      this.totalEnquity,
      this.vmEnquity,
      this.vmEnquityPer,
      this.listAssets});

  TotalAsset.fromJson(Map<String, dynamic> json) {
    totalNav = num.tryParse(json['total_nav']) ?? 0;
    totalCash = num.tryParse(json['total_cash']) ?? 0;
    totalEnquity = num.tryParse(json['total_enquity']) ?? 0;
    vmEnquity = num.tryParse(json['vm_enquity']) ?? 0;
    vmEnquityPer = num.tryParse(json['vm_enquity_per']) ?? 0;
    if (json['listAssets'] != null) {
      listAssets = <ListAssets>[];
      json['listAssets'].forEach((v) {
        listAssets!.add(ListAssets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_nav'] = totalNav;
    data['total_cash'] = totalCash;
    data['total_enquity'] = totalEnquity;
    data['vm_enquity'] = vmEnquity;
    data['vm_enquity_per'] = vmEnquityPer;
    if (listAssets != null) {
      data['listAssets'] = listAssets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListAssets {
  String? type;
  num? percentNav;
  num? nav;
  num? cash;

  ListAssets({this.type, this.percentNav, this.nav, this.cash});

  ListAssets.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    percentNav = num.tryParse(json['percent_nav']) ?? 0;
    nav = num.tryParse(json['nav']) ?? 0;
    cash = num.tryParse(json['cash']) ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['percent_nav'] = percentNav;
    data['nav'] = nav;
    data['cash'] = cash;
    return data;
  }
}
