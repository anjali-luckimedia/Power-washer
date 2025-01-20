
class UserProfileModel {
  String? message;
  String? status;
  List<Data>? data;

  UserProfileModel({this.message, this.status, this.data});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  UserDetails? userDetails;

  Data({this.userId, this.userDetails});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userDetails = json['user_details'] != null
        ? new UserDetails.fromJson(json['user_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    if (this.userDetails != null) {
      data['user_details'] = this.userDetails!.toJson();
    }
    return data;
  }
}

class UserDetails {
  String? profileImage;
  String? fullName;
  String? name;
  String? email;
  String? phone;

  UserDetails(
      {this.profileImage, this.fullName, this.name, this.email, this.phone});

  UserDetails.fromJson(Map<String, dynamic> json) {
    profileImage = json['profile_image'];
    fullName = json['full name'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_image'] = this.profileImage;
    data['full name'] = this.fullName;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}
