class GalleryModel {
  String? status;
  String? message;
  List<Data>? data;

  GalleryModel({this.status, this.message, this.data});

  GalleryModel.fromJson(Map<String, dynamic> json) {
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
  String? galleryId;
  String? type;
  String? fileUrl;

  Data({this.galleryId, this.type, this.fileUrl});

  Data.fromJson(Map<String, dynamic> json) {
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
