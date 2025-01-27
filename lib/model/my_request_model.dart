class MyRequestModel {
  String? status;
  String? message;
  List<Data>? data;

  MyRequestModel({this.status, this.message, this.data});

  MyRequestModel.fromJson(Map<String, dynamic> json) {
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
  String? bookingId;
  String? serviceId;
  String? image;
  String? name;
  String? date;
  String? address;
  String? services;
  String? status;

  Data(
      {this.bookingId,
        this.serviceId,
        this.image,
        this.name,
        this.date,
        this.address,
        this.services,
        this.status});

  Data.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    serviceId = json['service_id'];
    image = json['image'];
    name = json['name'];
    date = json['date'];
    address = json['address'];
    services = json['services'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_id'] = this.bookingId;
    data['service_id'] = this.serviceId;
    data['image'] = this.image;
    data['name'] = this.name;
    data['date'] = this.date;
    data['address'] = this.address;
    data['services'] = this.services;
    data['status'] = this.status;
    return data;
  }
}
