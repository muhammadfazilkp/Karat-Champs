class DataItem {
  final String name;

  DataItem({required this.name});

  factory DataItem.fromJson(Map<String, dynamic> json) {
    return DataItem(name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name};
  }
}

class ClassModel {
  final List<DataItem> data;

  ClassModel({required this.data});

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<DataItem> items = dataList.map((e) => DataItem.fromJson(e)).toList();
    return ClassModel(data: items);
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}



class Students {
  Data? data;

  Students({this.data});

  Students.fromJson(Map<String, dynamic> json) {
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(data != null) {
      _data["data"] = data?.toJson();
    }
    return _data;
  }
}

class Data {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  String? fullName;
  String? email;
  String? phone;
  String? institute;
  String? enrollmentDate;
  int? active;
  String? registrationDate;
  String? beltChangeDate;
  String? doctype;

  Data({this.name, this.owner, this.creation, this.modified, this.modifiedBy, this.docstatus, this.idx, this.fullName, this.email, this.phone, this.institute, this.enrollmentDate, this.active, this.registrationDate, this.beltChangeDate, this.doctype});

  Data.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    owner = json["owner"];
    creation = json["creation"];
    modified = json["modified"];
    modifiedBy = json["modified_by"];
    docstatus = json["docstatus"];
    idx = json["idx"];
    fullName = json["full_name"];
    email = json["email"];
    phone = json["phone"];
    institute = json["institute"];
    enrollmentDate = json["enrollment_date"];
    active = json["active"];
    registrationDate = json["registration_date"];
    beltChangeDate = json["belt_change_date"];
    doctype = json["doctype"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["name"] = name;
    _data["owner"] = owner;
    _data["creation"] = creation;
    _data["modified"] = modified;
    _data["modified_by"] = modifiedBy;
    _data["docstatus"] = docstatus;
    _data["idx"] = idx;
    _data["full_name"] = fullName;
    _data["email"] = email;
    _data["phone"] = phone;
    _data["institute"] = institute;
    _data["enrollment_date"] = enrollmentDate;
    _data["active"] = active;
    _data["registration_date"] = registrationDate;
    _data["belt_change_date"] = beltChangeDate;
    _data["doctype"] = doctype;
    return _data;
  }
}