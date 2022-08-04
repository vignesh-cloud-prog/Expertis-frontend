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
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.review != null) {
      data['review'] = this.review!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
