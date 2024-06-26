class ProductModel {
  String? name;
  Fields? fields;
  String? createTime;
  String? updateTime;

  ProductModel({this.name, this.fields, this.createTime, this.updateTime});

  ProductModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    fields = json['fields'] != null ? Fields.fromJson(json['fields']) : null;
    createTime = json['createTime'];
    updateTime = json['updateTime'];
  }
}

class Fields {
  IsOnSale? isOnSale;
  ProductId? productId;
  ProductId? price;
  ProductId? category;
  ProductId? title;
  ProductId? onSalePrice;
  ProductId? mainImage;
  ProductImage? productImage;
  ProductId? description;

  Fields(
      {this.isOnSale,
      this.productId,
      this.price,
      this.category,
      this.title,
      this.onSalePrice,
      this.mainImage,
      this.productImage,
      this.description});

  Fields.fromJson(Map<String, dynamic> json) {
    isOnSale = json['is_on_sale'] != null
        ? IsOnSale.fromJson(json['is_on_sale'])
        : null;
    productId = json['product_id'] != null
        ? ProductId.fromJson(json['product_id'])
        : null;
    price = json['price'] != null ? ProductId.fromJson(json['price']) : null;
    category =
        json['category'] != null ? ProductId.fromJson(json['category']) : null;
    title = json['title'] != null ? ProductId.fromJson(json['title']) : null;
    onSalePrice = json['on_sale_price'] != null
        ? ProductId.fromJson(json['on_sale_price'])
        : null;
    mainImage = json['main_image'] != null
        ? ProductId.fromJson(json['main_image'])
        : null;
    productImage = json['product_image'] != null
        ? ProductImage.fromJson(json['product_image'])
        : null;
    description = json['description'] != null
        ? ProductId.fromJson(json['description'])
        : null;
  }
}

class IsOnSale {
  bool? booleanValue;

  IsOnSale({this.booleanValue});

  IsOnSale.fromJson(Map<String, dynamic> json) {
    booleanValue = json['booleanValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['booleanValue'] = booleanValue;
    return data;
  }
}

class ProductId {
  String? stringValue;

  ProductId({this.stringValue});

  ProductId.fromJson(Map<String, dynamic> json) {
    stringValue = json['stringValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stringValue'] = stringValue;
    return data;
  }
}

class ProductImage {
  ArrayValue? arrayValue;

  ProductImage({this.arrayValue});

  ProductImage.fromJson(Map<String, dynamic> json) {
    arrayValue = json['arrayValue'] != null
        ? ArrayValue.fromJson(json['arrayValue'])
        : null;
  }
} 

class ArrayValue {
  List<String>? values;

  ArrayValue({this.values});

  ArrayValue.fromJson(Map<String, dynamic> json) {
    if (json['values'] != null) {
      values = <String>[];
      json['values'].forEach((v) {
        values!.add(v["stringValue"]);
      });
    }
  }
}
