import 'package:beamer/beamer.dart';
import 'package:expertis/components/category_admin_component.dart';
import 'package:expertis/data/response/status.dart';
import 'package:expertis/main.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/utils/BMColors.dart';
import 'package:expertis/view_model/categories_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class AdminTagsHomeScreen extends StatefulWidget {
  AdminTagsHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminTagsHomeScreen> createState() => _AdminTagsHomeScreenState();
}

class _AdminTagsHomeScreenState extends State<AdminTagsHomeScreen> {
  CategoryViewModel categoryViewModel = CategoryViewModel();

  @override
  void initState() {
    if (categoryViewModel.categoryList.data == null) {
      categoryViewModel.fetchCategoryListApi();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AppButton(
            width: double.infinity,
            color: bmPrimaryColor,
            text: 'Add Category',
            onTap: () {
              Beamer.of(context).beamToNamed(RoutesName.createTag);
            },
          ).paddingAll(16),
          ChangeNotifierProvider<CategoryViewModel>.value(
            value: categoryViewModel,
            child: Consumer<CategoryViewModel>(builder: (context, value, _) {
              switch (value.categoryList.status) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return Center(
                      child: Text(value.categoryList.message.toString()));
                case Status.COMPLETED:
                  print(
                      ' picture  ${value.categoryList.data?.categories?.first.tagPic}');
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: value.categoryList.data?.categories?.length,
                      itemBuilder: (ctx, index) {
                        return Container(
                          decoration: BoxDecoration(
                              color: appStore.isDarkModeOn ? white : white,
                              borderRadius: radius(20)),
                          child: CategoryAdminCardComponent(
                            category:
                                value.categoryList.data?.categories![index],
                          ),
                        ).paddingAll(8);
                      });
                default:
                  return Container();
              }
            }),
          ),
        ],
      ),
    );
  }
}
