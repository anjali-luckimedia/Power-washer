class NotificationModel {
  String? status;
  String? message;
  List<Data>? data;

  NotificationModel({this.status, this.message, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? notificationId;
  String? image;
  String? notificationText;
  String? notificationTitle;
  String? timestamp;
  String? time;

  Data(
      {this.notificationId,
        this.image,
        this.notificationText,
        this.notificationTitle,
        this.timestamp,
        this.time});

  Data.fromJson(Map<String, dynamic> json) {
    notificationId = json['notification_id'];
    image = json['image'];
    notificationText = json['notification_text'];
    notificationTitle = json['notification_title'];
    timestamp = json['timestamp'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notification_id'] = this.notificationId;
    data['image'] = this.image;
    data['notification_text'] = this.notificationText;
    data['notification_title'] = this.notificationTitle;
    data['timestamp'] = this.timestamp;
    data['time'] = this.time;
    return data;
  }
}
