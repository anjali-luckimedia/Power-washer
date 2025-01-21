class ServiceDetailsModel {
  String? message;
  String? status;
  Data? data;

  ServiceDetailsModel({this.message, this.status, this.data});

  ServiceDetailsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  ImageSection? imageSection;
  ServiceDetails? serviceDetails;
  Description? description;
  List<Services>? services;

  Data(
      {this.imageSection,
        this.serviceDetails,
        this.description,
        this.services});

  Data.fromJson(Map<String, dynamic> json) {
    imageSection = json['imageSection'] != null
        ? new ImageSection.fromJson(json['imageSection'])
        : null;
    serviceDetails = json['serviceDetails'] != null
        ? new ServiceDetails.fromJson(json['serviceDetails'])
        : null;
    description = json['description'] != null
        ? new Description.fromJson(json['description'])
        : null;
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.imageSection != null) {
      data['imageSection'] = this.imageSection!.toJson();
    }
    if (this.serviceDetails != null) {
      data['serviceDetails'] = this.serviceDetails!.toJson();
    }
    if (this.description != null) {
      data['description'] = this.description!.toJson();
    }
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImageSection {
  String? image;
  List<String>? gallery;

  ImageSection({this.image, this.gallery});

  ImageSection.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    gallery = json['gallery'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['gallery'] = this.gallery;
    return data;
  }
}

class ServiceDetails {
  String? name;
  String? distance;
  Location? location;
  Rating? rating;
  String? experience;

  ServiceDetails(
      {this.name, this.distance, this.location, this.rating, this.experience});

  ServiceDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    distance = json['distance'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    rating =
    json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
    experience = json['experience'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['distance'] = this.distance;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.rating != null) {
      data['rating'] = this.rating!.toJson();
    }
    data['experience'] = this.experience;
    return data;
  }
}

class Location {
  String? icon;
  String? address;

  Location({this.icon, this.address});

  Location.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['address'] = this.address;
    return data;
  }
}

class Rating {
  double? score;
  int? reviews;

  Rating({this.score, this.reviews});

  Rating.fromJson(Map<String, dynamic> json) {
    score = json['score'];
    reviews = json['reviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['score'] = this.score;
    data['reviews'] = this.reviews;
    return data;
  }
}

class Description {
  String? content;

  Description({this.content});

  Description.fromJson(Map<String, dynamic> json) {
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    return data;
  }
}

class Services {
  String? name;
  String? image;
  String? backgroundColor;

  Services({this.name, this.image, this.backgroundColor});

  Services.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    backgroundColor = json['backgroundColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['backgroundColor'] = this.backgroundColor;
    return data;
  }
}
