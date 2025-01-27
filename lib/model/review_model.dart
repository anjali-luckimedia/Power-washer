class ReviewModel {
  String? status;
  String? message;
  List<Data>? data;

  ReviewModel({this.status, this.message, this.data});

  ReviewModel.fromJson(Map<String, dynamic> json) {
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
  String? reviewId;
  String? name;
  String? profileImage;
  String? timestamp;
  int? rating;
  List<String>? categories;
  String? reviewText;
  String? replyText;

  Data(
      {this.reviewId,
        this.name,
        this.profileImage,
        this.timestamp,
        this.rating,
        this.categories,
        this.reviewText,
        this.replyText});

  Data.fromJson(Map<String, dynamic> json) {
    reviewId = json['review_id'];
    name = json['name'];
    profileImage = json['profileImage'];
    timestamp = json['timestamp'];
    rating = json['rating'];
    categories = json['categories'].cast<String>();
    reviewText = json['reviewText'];
    replyText = json['replyText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['review_id'] = this.reviewId;
    data['name'] = this.name;
    data['profileImage'] = this.profileImage;
    data['timestamp'] = this.timestamp;
    data['rating'] = this.rating;
    data['categories'] = this.categories;
    data['reviewText'] = this.reviewText;
    data['replyText'] = this.replyText;
    return data;
  }
}
