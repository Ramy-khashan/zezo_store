class OrderModel {
  String? address;
  String? city;
  String? totalPrice;
  String? paymentStatus;
  String? createdAt;
  String? building;
  List<Products>? products;
  String? fullName;
  String? userId;
  String? street;
  String? phoneNumber;
  String? payment;
  String? state;
  String? orderId;
  String? email;
  String? status;

  OrderModel(
      {this.address,
      this.city,
      this.totalPrice,
      this.paymentStatus,
      this.createdAt,
      this.building,
      this.products,
      this.fullName,
      this.userId,
      this.street,
      this.phoneNumber,
      this.payment,
      this.state,
      this.orderId,
      this.email,
      this.status});

  OrderModel.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    city = json['city'];
    totalPrice = json['totalPrice'];
    paymentStatus = json['payment_status'];
    createdAt = json['created_at'];
    building = json['building'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    fullName = json['full_name'];
    userId = json['user_id'];
    street = json['street'];
    phoneNumber = json['phone_number'];
    payment = json['payment'];
    state = json['state'];
    orderId = json['order_id'];
    email = json['email'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['city'] = this.city;
    data['totalPrice'] = this.totalPrice;
    data['payment_status'] = this.paymentStatus;
    data['created_at'] = this.createdAt;
    data['building'] = this.building;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['full_name'] = this.fullName;
    data['user_id'] = this.userId;
    data['street'] = this.street;
    data['phone_number'] = this.phoneNumber;
    data['payment'] = this.payment;
    data['state'] = this.state;
    data['order_id'] = this.orderId;
    data['email'] = this.email;
    data['status'] = this.status;
    return data;
  }
}

class Products {
  String? image;
  String? quantity;
  String? price;
  String? productId;
  String? title;

  Products({this.image, this.quantity, this.price, this.productId, this.title});

  Products.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    quantity = json['quantity'];
    price = json['price'];
    productId = json['product_id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['product_id'] = this.productId;
    data['title'] = this.title;
    return data;
  }
}
