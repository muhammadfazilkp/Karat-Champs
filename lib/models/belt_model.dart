class BeltModel {
  List<Data>? data;

  BeltModel({this.data});

  BeltModel.fromJson(Map<String, dynamic> json) {
    data = json["data"] == null
        ? null
        : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Data {
  String? name;

  Data({this.name});

  Data.fromJson(Map<String, dynamic> json) {
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["name"] = name;
    return _data;
  }
}

class Guardian {
  List<Data>? data;
  Guardian({this.data});

  Guardian.fromJson(Map<String, dynamic> json) {
    data = json["data"] == null
        ? null
        : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class GuardianData {
  String? name;
  GuardianData({this.name});
  GuardianData.fromJson(Map<String, dynamic> json) {
    name = json["name"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> detail = <String, dynamic>{};
    detail["name"] = name;
    return detail;
  }
}
