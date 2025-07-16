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
    from = json['from'] != null ? UserModel.fromJson(json['from']) : null;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['from'] = from;
    data['model_type'] = modelType;
    data['to'] = to;
    data['comment'] = comment;
    data['createdAt'] = createdAt;
    data['rating'] = rating;
    data['reviewPhotos'] = reviewPhotos;
    data['updatedAt'] = updatedAt;
    data['id'] = id;
    data['title'] = title;

    return data;
  }
}
