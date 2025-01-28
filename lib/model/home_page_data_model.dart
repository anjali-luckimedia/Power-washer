class HomeDataModel {
  String? status;
  String? message;
  Data? data;

  HomeDataModel({this.status, this.message, this.data});

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Banners>? banners;
  List<Services>? services;
  List<MostBookedServices>? mostBookedServices;
  List<Curations>? curations;

  Data({this.banners, this.services, this.mostBookedServices, this.curations});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(new Banners.fromJson(v));
      });
    }
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    if (json['most_booked_services'] != null) {
      mostBookedServices = <MostBookedServices>[];
      json['most_booked_services'].forEach((v) {
        mostBookedServices!.add(new MostBookedServices.fromJson(v));
      });
    }
    if (json['curations'] != null) {
      curations = <Curations>[];
      json['curations'].forEach((v) {
        curations!.add(new Curations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.banners != null) {
      data['banners'] = this.banners!.map((v) => v.toJson()).toList();
    }
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    if (this.mostBookedServices != null) {
      data['most_booked_services'] =
          this.mostBookedServices!.map((v) => v.toJson()).toList();
    }
    if (this.curations != null) {
      data['curations'] = this.curations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banners {
  String? bannerId;
  String? serviceId;
  String? title;
  String? highlight;
  String? caption;
  String? image;

  Banners(
      {this.bannerId,
        this.serviceId,
        this.title,
        this.highlight,
        this.caption,
        this.image});

  Banners.fromJson(Map<String, dynamic> json) {
    bannerId = json['banner_id'];
    serviceId = json['service_id'];
    title = json['title'];
    highlight = json['highlight'];
    caption = json['caption'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['banner_id'] = this.bannerId;
    data['service_id'] = this.serviceId;
    data['title'] = this.title;
    data['highlight'] = this.highlight;
    data['caption'] = this.caption;
    data['image'] = this.image;
    return data;
  }
}

class Services {
  String? categoryId;
  String? name;
  String? image;

  Services({this.categoryId, this.name, this.image});

  Services.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

class MostBookedServices {
  String? serviceId;
  String? image;
  String? name;
  String? services;
  dynamic? rating;
  int? reviews;
  String? yearsOfExperience;
  String? distance;
  String? latitude;
  String? longitude;

  MostBookedServices(
      {this.serviceId,
        this.image,
        this.name,
        this.services,
        this.rating,
        this.reviews,
        this.yearsOfExperience,
        this.distance,
        this.latitude,
        this.longitude});

  MostBookedServices.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    image = json['image'];
    name = json['name'];
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

class Curations {
  String? curationId;
  String? serviceId;
  String? url;
  String? name;
  dynamic? rating;
  int? reviews;
  String? yearsOfExperience;

  Curations(
      {this.curationId,
        this.serviceId,
        this.url,
        this.name,
        this.rating,
        this.reviews,
        this.yearsOfExperience});

  Curations.fromJson(Map<String, dynamic> json) {
    curationId = json['curation_id'];
    serviceId = json['service_id'];
    url = json['url'];
    name = json['name'];
    rating = json['rating'];
    reviews = json['reviews'];
    yearsOfExperience = json['years_of_experience'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['curation_id'] = this.curationId;
    data['service_id'] = this.serviceId;
    data['url'] = this.url;
    data['name'] = this.name;
    data['rating'] = this.rating;
    data['reviews'] = this.reviews;
    data['years_of_experience'] = this.yearsOfExperience;
    return data;
  }
}
