import 'package:expertis/models/review_model.dart';

class ReviewListModel {
  List<ReviewModel>? review;

  ReviewListModel({this.review});

  ReviewListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      review = <ReviewModel>[];
      json['data'].forEach((v) {
        review!.add(ReviewModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (review != null) {
      data['review'] = review!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
