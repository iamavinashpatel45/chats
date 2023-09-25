class chat_module {
  bool? type;
  String? message;
  String? date;
  String? time;
  bool? image;

  chat_module({this.type, this.message, this.date, this.time, this.image});

  chat_module.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    date = json['date'];
    time = json['time'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['message'] = this.message;
    data['date'] = this.date;
    data['time'] = this.time;
    data['image'] = this.image;
    return data;
  }
}
