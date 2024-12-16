class Books {
  List<Product>? product;

  Books({this.product});

  Books.fromJson(Map<String, dynamic> json) {
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  String? author;
  String? cover;
  String? createdAt;
  String? description;
  int? id;
  String? name;
  num? price;
  int? sales;
  String? slug;
  LikesAggregate? likesAggregate;

  Product(
      {this.author,
      this.cover,
      this.createdAt,
      this.description,
      this.id,
      this.name,
      this.price,
      this.sales,
      this.slug,
      this.likesAggregate});

  Product.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    cover = json['cover'];
    createdAt = json['created_at'];
    description = json['description'];
    id = json['id'];
    name = json['name'];
    price = json['price'];
    sales = json['sales'];
    slug = json['slug'];
    likesAggregate = json['likes_aggregate'] != null
        ? new LikesAggregate.fromJson(json['likes_aggregate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author'] = this.author;
    data['cover'] = this.cover;
    data['created_at'] = this.createdAt;
    data['description'] = this.description;
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['sales'] = this.sales;
    data['slug'] = this.slug;
    if (this.likesAggregate != null) {
      data['likes_aggregate'] = this.likesAggregate!.toJson();
    }
    return data;
  }
}

class LikesAggregate {
  Aggregate? aggregate;

  LikesAggregate({this.aggregate});

  LikesAggregate.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new Aggregate.fromJson(json['aggregate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aggregate != null) {
      data['aggregate'] = this.aggregate!.toJson();
    }
    return data;
  }
}

class Aggregate {
  int? count;

  Aggregate({this.count});

  Aggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    return data;
  }
}
