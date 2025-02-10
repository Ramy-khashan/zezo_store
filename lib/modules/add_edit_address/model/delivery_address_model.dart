class DeliveryAddressModel {
  String? id;
  String? fullName;
  String? phone1;
  String? phone2;
  String? fullAddress;
  String? building;
  String? city;
  String? street;
  String? landmark;

  DeliveryAddressModel(
      {this.id,
      this.fullName,
      this.phone1,
      this.phone2,
      this.fullAddress,
      this.building,
      this.city,
      this.street,
      this.landmark});

  DeliveryAddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    phone1 = json['phone1'];
    phone2 = json['phone2'];
    building = json['building'];
    city = json['city'];
    street = json['street'];
    fullAddress = json['full_address'];
    landmark = json['landmark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['phone1'] = this.phone1;
    data['phone2'] = this.phone2;
    data['building'] = this.building;
    data['city'] = this.city;
    data['street'] = this.street;
    data['full_address'] = this.fullAddress;
    data['landmark'] = this.landmark;
    return data;
  }
}
