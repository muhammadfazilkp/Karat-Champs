
class StudentDetails {
  List<Data>? data;

  StudentDetails({this.data});

  StudentDetails.fromJson(Map<String, dynamic> json) {
    data = json["data"] == null ? null : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
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
  dynamic guardianName;
  dynamic guardianPhone;
  dynamic guardianRelationship;
  String? registrationDate;
  dynamic belt;
  String? beltChangeDate;

  Data({this.name, this.owner, this.creation, this.modified, this.modifiedBy, this.docstatus, this.idx, this.fullName, this.email, this.phone, this.institute, this.enrollmentDate, this.active, this.guardianName, this.guardianPhone, this.guardianRelationship, this.registrationDate, this.belt, this.beltChangeDate});

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
    guardianName = json["guardian_name"];
    guardianPhone = json["guardian_phone"];
    guardianRelationship = json["guardian_relationship"];
    registrationDate = json["registration_date"];
    belt = json["belt"];
    beltChangeDate = json["belt_change_date"];
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
    _data["guardian_name"] = guardianName;
    _data["guardian_phone"] = guardianPhone;
    _data["guardian_relationship"] = guardianRelationship;
    _data["registration_date"] = registrationDate;
    _data["belt"] = belt;
    _data["belt_change_date"] = beltChangeDate;
    return _data;
  }
}