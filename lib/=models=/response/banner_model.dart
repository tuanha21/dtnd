// class BannerModel {
//   int? rc;
//   String? rs;
//   List<Data>? data;
//
//   BannerModel({required this.rc, required this.rs, required this.data});
//
//   BannerModel.fromJson(Map<String, dynamic> json) {
//     rc = json['rc'];
//     rs = json['rs'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data?.add(Data.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['rc'] = rc;
//     data['rs'] = rs;
//     data['data'] = this.data?.map((v) => v.toJson()).toList();
//     return data;
//   }
// }

class DataBanner {
  String? title;
  String? img;
  String? url;

  DataBanner({required this.title, required this.img, required this.url});

  DataBanner.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    img = json['img'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['img'] = img;
    data['url'] = url;
    return data;
  }

  @override
  String toString() {
    return 'DataBanner{title: $title, img: $img, url: $url}';
  }
}
