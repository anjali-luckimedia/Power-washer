
class ReviewModel {
  String? message;
  String? status;
  Data? data;

  ReviewModel({this.message, this.status, this.data});

  ReviewModel.fromJson(Map<String, dynamic> json) {
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
  List<Reviews>? reviews;

  Data({this.reviews});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reviews {
  String? name;
  String? profileImage;
  String? timestamp;
  double? rating;
  List<String>? categories;
  String? reviewText;

  Reviews(
      {this.name,
        this.profileImage,
        this.timestamp,
        this.rating,
        this.categories,
        this.reviewText});

  Reviews.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profileImage = json['profileImage'];
    timestamp = json['timestamp'];
    rating = json['rating'];
    categories = json['categories'].cast<String>();
    reviewText = json['reviewText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['profileImage'] = this.profileImage;
    data['timestamp'] = this.timestamp;
    data['rating'] = this.rating;
    data['categories'] = this.categories;
    data['reviewText'] = this.reviewText;
    return data;
  }
}
