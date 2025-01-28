/*
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
*/
class ServiceDetailsModel {
  String? status;
  String? message;
  Data? data;

  ServiceDetailsModel({this.status, this.message, this.data});

  ServiceDetailsModel.fromJson(Map<String, dynamic> json) {
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
  ImageSection? imageSection;
  ServiceDetails? serviceDetails;
  List<Services>? services;

  Data({this.imageSection, this.serviceDetails, this.services});

  Data.fromJson(Map<String, dynamic> json) {
    imageSection = json['imageSection'] != null
        ? new ImageSection.fromJson(json['imageSection'])
        : null;
    serviceDetails = json['serviceDetails'] != null
        ? new ServiceDetails.fromJson(json['serviceDetails'])
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
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImageSection {
  Gallery? image;
  List<Gallery>? gallery;
  int? count;


  ImageSection({this.image, this.gallery,this.count});

  ImageSection.fromJson(Map<String, dynamic> json) {
    image = json['image'] != null ? new Gallery.fromJson(json['image']) : null;
    if (json['gallery'] != null) {
      gallery = <Gallery>[];
      json['gallery'].forEach((v) {
        gallery!.add(new Gallery.fromJson(v));
      });
    }
    count = json['count'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    if (this.gallery != null) {
      data['gallery'] = this.gallery!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;

    return data;
  }
}


class Gallery {
  String? galleryId;
  String? type;
  String? fileUrl;

  Gallery({this.galleryId, this.type, this.fileUrl});

  Gallery.fromJson(Map<String, dynamic> json) {
    galleryId = json['gallery_id'];
    type = json['type'];
    fileUrl = json['file_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gallery_id'] = this.galleryId;
    data['type'] = this.type;
    data['file_url'] = this.fileUrl;
    return data;
  }
}

class ServiceDetails {
  String? id;
  String? name;
  String? distance;
  String? location;
  String? description;
  Rating? rating;
  String? experience;

  ServiceDetails(
      {this.id,this.name,
        this.distance,
        this.location,
        this.description,
        this.rating,
        this.experience});

  ServiceDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    distance = json['distance'];
    location = json['location'];
    description = json['description'];
    rating =
    json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
    experience = json['experience'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['distance'] = this.distance;
    data['location'] = this.location;
    data['description'] = this.description;
    if (this.rating != null) {
      data['rating'] = this.rating!.toJson();
    }
    data['experience'] = this.experience;
    return data;
  }
}

class Rating {
  dynamic? score;
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
