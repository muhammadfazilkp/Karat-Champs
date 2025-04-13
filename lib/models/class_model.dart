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
