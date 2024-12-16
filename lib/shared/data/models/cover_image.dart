class CoverImage {
  ActionProductImage? actionProductImage;

  CoverImage({this.actionProductImage});

  CoverImage.fromJson(Map<String, dynamic> json) {
    actionProductImage = json['action_product_image'] != null
        ? new ActionProductImage.fromJson(json['action_product_image'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.actionProductImage != null) {
      data['action_product_image'] = this.actionProductImage!.toJson();
    }
    return data;
  }
}

class ActionProductImage {
  String? url;

  ActionProductImage({this.url});

  ActionProductImage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}
