class ServiceModel {
  String? status;
  String? message;
  List<Data>? data;

  ServiceModel({this.status, this.message, this.data});

  ServiceModel.fromJson(Map<String, dynamic> json) {
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
  String? serviceId;
  String? image;
  String? name;
  String? address;
  String? services;
  dynamic? rating;
  int? reviews;
  String? yearsOfExperience;
  String? distance;
  String? latitude;
  String? longitude;

  Data(
      {this.serviceId,
        this.image,
        this.name,
        this.address,
        this.services,
        this.rating,
        this.reviews,
        this.yearsOfExperience,
        this.distance,
        this.latitude,
        this.longitude});

  Data.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    image = json['image'];
    name = json['name'];
    address = json['address'];
    services = json['services'];
    rating = json['rating'];
    reviews = json['reviews'];
    yearsOfExperience = json['years_of_experience'];
    distance = json['distance'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_id'] = this.serviceId;
    data['image'] = this.image;
    data['name'] = this.name;
    data['address'] = this.address;
    data['services'] = this.services;
    data['rating'] = this.rating;
    data['reviews'] = this.reviews;
    data['years_of_experience'] = this.yearsOfExperience;
    data['distance'] = this.distance;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
