import 'package:expertis/models/user_model.dart';

class ReviewModel {
  UserModel? from;
  String? modelType;
  String? to;
  String? comment;
  String? createdAt;
  String? rating;
  List<String>? reviewPhotos;
  String? updatedAt;
  String? id;
  String? title;

  ReviewModel(
      {this.from,
      this.modelType,
      this.to,
      this.title,
      this.comment,
      this.createdAt,
      this.rating,
      this.reviewPhotos,
      this.updatedAt,
      this.id});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    from = json['from'] != null ? new UserModel.fromJson(json['from']) : null;
    modelType = json['model_type'];
    to = json['to'];
    comment = json['comment'];
    createdAt = json['createdAt'];
    rating = json['rating'];
    reviewPhotos = json['reviewPhotos'].cast<String>();
    updatedAt = json['updatedAt'];
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from'] = this.from;
    data['model_type'] = this.modelType;
    data['to'] = this.to;
    data['comment'] = this.comment;
    data['createdAt'] = this.createdAt;
    data['rating'] = this.rating;
    data['reviewPhotos'] = this.reviewPhotos;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    data['title'] = this.title;

    return data;
  }
}
