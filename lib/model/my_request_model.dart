class MyRequestModel {
  String? message;
  String? status;
  List<Data>? data;

  MyRequestModel({this.message, this.status, this.data});

  MyRequestModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? date;
  String? address;
  String? services;
  String? status;

  Data(
      {this.image,
        this.name,
        this.date,
        this.address,
        this.services,
        this.status});

  Data.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
    date = json['date'];
    address = json['address'];
    services = json['services'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['name'] = this.name;
    data['date'] = this.date;
    data['address'] = this.address;
    data['services'] = this.services;
    data['status'] = this.status;
    return data;
  }
}
