class chat_module {
  bool? type;
  String? message;
  String? date;
  String? time;
  bool? seen;

  chat_module({this.type, this.message, this.date, this.time, this.seen});

  chat_module.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    date = json['date'];
    time = json['time'];
    seen = json['seen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['message'] = this.message;
    data['date'] = this.date;
    data['time'] = this.time;
    data['seen'] = this.seen;
    return data;
  }
}
