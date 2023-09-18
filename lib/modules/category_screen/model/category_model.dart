class CategoryModel {
  String? name;
  Fields? fields;
  String? createTime;
  String? updateTime;

  CategoryModel({this.name, this.fields, this.createTime, this.updateTime});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    fields = json['fields'] != null ? Fields.fromJson(json['fields']) : null;
    createTime = json['createTime'];
    updateTime = json['updateTime'];
  }
}

class Fields {
  Title? title;
  Title? categoryId;
  Title? categoryImage;

  Fields({this.title, this.categoryId, this.categoryImage});

  Fields.fromJson(Map<String, dynamic> json) {
    title = json['title'] != null ? Title.fromJson(json['title']) : null;
    categoryId = json['category_id'] != null
        ? Title.fromJson(json['category_id'])
        : null;
    categoryImage = json['category_image'] != null
        ? Title.fromJson(json['category_image'])
        : null;
  }
}

class Title {
  String? stringValue;

  Title({this.stringValue});

  Title.fromJson(Map<String, dynamic> json) {
    stringValue = json['stringValue'];
  }
}
