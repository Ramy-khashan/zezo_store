class WishlistModel {
  String? name;
  Fields? fields;
  String? createTime;
  String? updateTime;

  WishlistModel({this.name, this.fields, this.createTime, this.updateTime});

  WishlistModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    fields =
        json['fields'] != null ? Fields.fromJson(json['fields']) : null;
    createTime = json['createTime'];
    updateTime = json['updateTime'];
  }

  
}

class Fields {
  ProductName? productName;
  ProductName? productImage;
  ProductName? price;
  ProductName? productId;

  Fields({this.productName, this.productImage, this.price, this.productId});

  Fields.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'] != null
        ? ProductName.fromJson(json['product_name'])
        : null;
    productImage = json['product_image'] != null
        ? ProductName.fromJson(json['product_image'])
        : null;
    price =
        json['price'] != null ? ProductName.fromJson(json['price']) : null;
    productId = json['product_id'] != null
        ? ProductName.fromJson(json['product_id'])
        : null;
  }

   
}

class ProductName {
  String? stringValue;

  ProductName({this.stringValue});

  ProductName.fromJson(Map<String, dynamic> json) {
    stringValue = json['stringValue'];
  }

  
}
