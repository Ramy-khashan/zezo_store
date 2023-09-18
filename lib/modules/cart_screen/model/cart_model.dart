class CartModel {
  String? name;
  Fields? fields;
  String? createTime;
  String? updateTime;

  CartModel({this.name, this.fields, this.createTime, this.updateTime});

  CartModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    fields =
        json['fields'] != null ? Fields.fromJson(json['fields']) : null;
    createTime = json['createTime'];
    updateTime = json['updateTime'];
  }

   
}

class Fields {
  Price? price;
  Price? productId;
  Price? productImage;
  Price? productName;
  Quantity? quantity;

  Fields(
      {this.price,
      this.productId,
      this.productImage,
      this.productName,
      this.quantity});

  Fields.fromJson(Map<String, dynamic> json) {
    price = json['price'] != null ? Price.fromJson(json['price']) : null;
    productId = json['product_id'] != null
        ? Price.fromJson(json['product_id'])
        : null;
    productImage = json['product_image'] != null
        ? Price.fromJson(json['product_image'])
        : null;
    productName = json['product_name'] != null
        ? Price.fromJson(json['product_name'])
        : null;
    quantity = json['quantity'] != null
        ? Quantity.fromJson(json['quantity'])
        : null;
  }

  
}

class Price {
  String? stringValue;

  Price({this.stringValue});

  Price.fromJson(Map<String, dynamic> json) {
    stringValue = json['stringValue'];
  }

 
}

class Quantity {
  String? integerValue;

  Quantity({this.integerValue});

  Quantity.fromJson(Map<String, dynamic> json) {
    integerValue = json['integerValue'];
  }

  
}
