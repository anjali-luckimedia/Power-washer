class SearchModel {
  String? message;
  String? status;
  List<Data>? data;

  SearchModel({this.message, this.status, this.data});

  SearchModel.fromJson(Map<String, dynamic> json) {
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
  String? address;
  String? services;
  int? rating;
  int? reviews;
  String? yearsOfExperience;
  String? distance;

  Data(
      {this.image,
        this.name,
        this.address,
        this.services,
        this.rating,
        this.reviews,
        this.yearsOfExperience,
        this.distance});

  Data.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
    address = json['address'];
    services = json['services'];
    rating = json['rating'];
    reviews = json['reviews'];
    yearsOfExperience = json['years_of_experience'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['name'] = this.name;
    data['address'] = this.address;
    data['services'] = this.services;
    data['rating'] = this.rating;
    data['reviews'] = this.reviews;
    data['years_of_experience'] = this.yearsOfExperience;
    data['distance'] = this.distance;
    return data;
  }
}
