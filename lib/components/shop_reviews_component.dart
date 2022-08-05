import 'package:beamer/beamer.dart';
import 'package:expertis/components/BMCommentComponent.dart';
import 'package:expertis/components/review_component.dart';
import 'package:expertis/data/response/status.dart';
import 'package:expertis/models/BMCommentModel.dart';
import 'package:expertis/models/review_list_model.dart';
import 'package:expertis/models/review_model.dart';
import 'package:expertis/models/shop_model.dart';
import 'package:expertis/models/user_model.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/screens/review_shop_screen.dart';
import 'package:expertis/utils/BMColors.dart';
import 'package:expertis/utils/BMDataGenerator.dart';
import 'package:expertis/utils/BMWidgets.dart';
import 'package:expertis/view_model/review_list_view_model.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class ShopReviewComponent extends StatefulWidget {
  String? shopId;
  ShopModel? shop;
  ShopReviewComponent({Key? key, this.shopId, this.shop}) : super(key: key);

  @override
  State<ShopReviewComponent> createState() => _ShopReviewComponentState();
}

class _ShopReviewComponentState extends State<ShopReviewComponent> {
  bool edit = false;
  ReviewModel? userReview;
  final reviewListViewModel = ReviewListViewModel();

  void initState() {
    reviewListViewModel.fetchReviewDataApi(widget.shopId);
    // print("reviewlistviewmodel");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = Provider.of<UserViewModel>(context);
    print(userViewModel.user.id);
    print("user id ${userViewModel.user.id}");
    return ChangeNotifierProvider<ReviewListViewModel>.value(
      value: reviewListViewModel,
      child: Consumer<ReviewListViewModel>(builder: (context, value, _) {
        print("in notifier");
        switch (value.reviewList.status) {
          case Status.LOADING:
            print("in loading ");
            return const Center(child: CircularProgressIndicator());
          case Status.ERROR:
            print("in error ");
            return Center(
              child: Text(value.reviewList.message.toString()),
            );
          case Status.COMPLETED:
            List<ReviewModel>? reviews = value.reviewList.data?.review;
            reviews?.forEach((element) => {
                  if (element.from == userViewModel.user.id)
                    {
                      print("review is there"),
                      edit = true,
                      print("element ${element.toJson()}"),
                      userReview = element,
                      print("user review ${userReview?.toJson()}")
                    }
                });
            print("completed sucessfully");
            // print(
            //     "value ${value.shopList.data?.shops?.first.toJson()}");
            print("printed ${value.reviewList.data.toString()}");
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: bmPrimaryColor),
                    color: appStore.isDarkModeOn
                        ? appStore.scaffoldBackground!
                        : bmLightScaffoldBackgroundColor,
                    borderRadius: radius(18),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.edit, color: bmPrimaryColor),
                      8.width,
                      Text(edit ? 'Edit Review' : 'Write a Review',
                          style: boldTextStyle(color: bmPrimaryColor)),
                    ],
                  ).expand().center().onTap(() {
                    print("user review ${userReview.toString()}");
                    Beamer.of(context).beamToNamed(
                        RoutesName.reviewShopWithId(widget.shopId),
                        data: userReview);
                  }),
                ).paddingAll(8),
                16.height,
                Row(
                  children: [
                    titleText(title: 'Reviews', size: 20),
                    2.width,
                    titleText(
                      title: '(${value.reviewList.data?.review?.length})',
                      size: 16,
                    ),
                  ],
                ).paddingOnly(top: 8, bottom: 8, left: 10),
                10.height,
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: value.reviewList.data?.review?.length,
                    itemBuilder: (ctx, index) {
                      return ReviewComponent(
                          element: value.reviewList.data?.review![index]);
                    }),
              ],
            );
          default:
            return Container();
        }
      }),
    );
  }
}
