class contacts_module {
  String? name;
  String? num;
  String? id;
  String? image;

  contacts_module({this.name, this.num, this.id, this.image});

  contacts_module.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    num = json['num'];
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['num'] = this.num;
    data['id'] = this.id;
    data['image'] = this.image;
    return data;
  }
}
