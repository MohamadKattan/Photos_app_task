class ImagesModel {
  List<Items>? items;
  String? continuationToken;

  ImagesModel({this.items, this.continuationToken});

  ImagesModel.fromMap(Map<String, dynamic> map) {
    if (map['items'] != null) {
      items = <Items>[];
      map['items'].forEach((i) {
        items!.add(Items.fromJson(i));
      });
    }
    continuationToken = map['continuationToken'];
  }
}

class Items {
  String? id;
  List<Variants>? variants;

  Items({this.id, this.variants});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(Variants.fromJson(v));
      });
    }
  }
}

class Variants {
  int? width;
  int? height;
  String? url;

  Variants({this.width, this.height, this.url});

  Variants.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    height = json['height'];
    url = json['url'];
  }
}
