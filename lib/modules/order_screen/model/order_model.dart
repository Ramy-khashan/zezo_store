class OrderModel {
  String? name;
  Fields? fields;
  String? createTime;
  String? updateTime;

  OrderModel({this.name, this.fields, this.createTime, this.updateTime});

  OrderModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    fields =
        json['fields'] != null ? Fields.fromJson(json['fields']) : null;
    createTime = json['createTime'];
    updateTime = json['updateTime'];
  }
 
}

class Fields {
  Country? country;
  Country? address;
  Country? city;
  Country? totalPrice;
  Country? lastName;
  Country? createdAt;
  Country? building;
  Products? products;
  Country? userId;
  Country? shippingMethod;
  Country? street;
  Country? paymentData;
  Country? payment;
  Country? phoneNumber;
  Country? state;
  Country? floor;
  Country? postalCode;
  Country? firstName;
  Country? apartment;
  Country? email;

  Fields(
      {this.country,
      this.address,
      this.city,
      this.totalPrice,
      this.lastName,
      this.createdAt,
      this.building,
      this.products,
      this.userId,
      this.shippingMethod,
      this.street,
      this.paymentData,
      this.payment,
      this.phoneNumber,
      this.state,
      this.floor,
      this.postalCode,
      this.firstName,
      this.apartment,
      this.email});

  Fields.fromJson(Map<String, dynamic> json) {
    country =
        json['country'] != null ? Country.fromJson(json['country']) : null;
    address =
        json['address'] != null ? Country.fromJson(json['address']) : null;
    city = json['city'] != null ? Country.fromJson(json['city']) : null;
    totalPrice = json['totalPrice'] != null
        ? Country.fromJson(json['totalPrice'])
        : null;
    lastName = json['last_name'] != null
        ? Country.fromJson(json['last_name'])
        : null;
    createdAt = json['created_at'] != null
        ? Country.fromJson(json['created_at'])
        : null;
    building = json['building'] != null
        ? Country.fromJson(json['building'])
        : null;
    products = json['products'] != null
        ? Products.fromJson(json['products'])
        : null;
    userId =
        json['user_id'] != null ? Country.fromJson(json['user_id']) : null;
    shippingMethod = json['shipping_method'] != null
        ? Country.fromJson(json['shipping_method'])
        : null;
    street =
        json['street'] != null ? Country.fromJson(json['street']) : null;
    paymentData = json['payment_data'] != null
        ? Country.fromJson(json['payment_data'])
        : null;
    payment =
        json['payment'] != null ? Country.fromJson(json['payment']) : null;
    phoneNumber = json['phone_number'] != null
        ? Country.fromJson(json['phone_number'])
        : null;
    state = json['state'] != null ? Country.fromJson(json['state']) : null;
    floor = json['floor'] != null ? Country.fromJson(json['floor']) : null;
    postalCode = json['postal_code'] != null
        ? Country.fromJson(json['postal_code'])
        : null;
    firstName = json['first_name'] != null
        ? Country.fromJson(json['first_name'])
        : null;
    apartment = json['apartment'] != null
        ? Country.fromJson(json['apartment'])
        : null;
    email = json['email'] != null ? Country.fromJson(json['email']) : null;
  }
 
}

class Country {
  String? stringValue;

  Country({this.stringValue});

  Country.fromJson(Map<String, dynamic> json) {
    stringValue = json['stringValue'];
  }
 
}

class Products {
  ArrayValue? arrayValue;

  Products({this.arrayValue});

  Products.fromJson(Map<String, dynamic> json) {
    arrayValue = json['arrayValue'] != null
        ? ArrayValue.fromJson(json['arrayValue'])
        : null;
  }
 
}

class ArrayValue {
  List<Values>? values;

  ArrayValue({this.values});

  ArrayValue.fromJson(Map<String, dynamic> json) {
    if (json['values'] != null) {
      values = <Values>[];
      json['values'].forEach((v) {
        values!.add(Values.fromJson(v));
      });
    }
  }

 
}

class Values {
  MapValue? mapValue;

  Values({this.mapValue});

  Values.fromJson(Map<String, dynamic> json) {
    mapValue = json['mapValue'] != null
        ? MapValue.fromJson(json['mapValue'])
        : null;
  }

 
}

class MapValue {
  ProductsFields? fields;

  MapValue({this.fields});

  MapValue.fromJson(Map<String, dynamic> json) {
    fields =
        json['fields'] != null ? ProductsFields.fromJson(json['fields']) : null;
  }
 
}

class ProductsFields {
  Country? image;
  Country? quantity;
  Country? price;
  Country? productId;
  Country? title;

  ProductsFields({this.image, this.quantity, this.price, this.productId, this.title});

  ProductsFields.fromJson(Map<String, dynamic> json) {
    image = json['image'] != null ? Country.fromJson(json['image']) : null;
    quantity = json['quantity'] != null
        ? Country.fromJson(json['quantity'])
        : null;
    price = json['price'] != null ? Country.fromJson(json['price']) : null;
    productId = json['product_id'] != null
        ? Country.fromJson(json['product_id'])
        : null;
    title = json['title'] != null ? Country.fromJson(json['title']) : null;
  }
 
}
