class NotificationModel {
  String? message;
  String? status;
  List<Data>? data;

  NotificationModel({this.message, this.status, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? image;
  String? title;
  String? message;
  String? date;
  String? time;

  Data({this.image, this.title, this.message, this.date, this.time});

  Data.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
    message = json['message'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['title'] = this.title;
    data['message'] = this.message;
    data['date'] = this.date;
    data['time'] = this.time;
    return data;
  }
}
