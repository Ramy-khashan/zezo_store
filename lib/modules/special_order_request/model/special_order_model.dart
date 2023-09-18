class SpecialOrderModel {
  String? name;
  Fields? fields;
  String? createTime;
  String? updateTime;

  SpecialOrderModel({this.name, this.fields, this.createTime, this.updateTime});

  SpecialOrderModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    fields = json['fields'] != null ? Fields.fromJson(json['fields']) : null;
    createTime = json['createTime'];
    updateTime = json['updateTime'];
  }
}

class Fields {
  SpecialOrder? specialOrder;
  SpecialOrder? fullName;
  SpecialOrder? description;
  SpecialOrder? address;
  SpecialOrder? email;
  SpecialOrder? phone;
  SpecialOrder? userId;
  SpecialOrder? status;

  Fields(
      {this.specialOrder,
      this.fullName,
      this.description,
      this.address,
      this.email,
      this.phone,
      this.status,
      this.userId});

  Fields.fromJson(Map<String, dynamic> json) {
    specialOrder = json['special_order'] != null
        ? SpecialOrder.fromJson(json['special_order'])
        : null;
    fullName = json['full_name'] != null
        ? SpecialOrder.fromJson(json['full_name'])
        : null; status = json['status'] != null
        ? SpecialOrder.fromJson(json['status'])
        : null;
    description = json['description'] != null
        ? SpecialOrder.fromJson(json['description'])
        : null;
    address =
        json['address'] != null ? SpecialOrder.fromJson(json['address']) : null;
    email = json['email'] != null ? SpecialOrder.fromJson(json['email']) : null;
    phone = json['phone'] != null ? SpecialOrder.fromJson(json['phone']) : null;
    userId =
        json['user_id'] != null ? SpecialOrder.fromJson(json['user_id']) : null;
  }
}

class SpecialOrder {
  String? stringValue;

  SpecialOrder({this.stringValue});

  SpecialOrder.fromJson(Map<String, dynamic> json) {
    stringValue = json['stringValue'];
  }
}
