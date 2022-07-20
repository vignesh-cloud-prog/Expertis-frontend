import 'package:expertis/models/shop_list_model.dart';
import 'package:expertis/view_model/shop_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../models/BMServiceListModel.dart';
import '../utils/BMColors.dart';
import '../utils/BMDataGenerator.dart';
import '../utils/BMWidgets.dart';
import 'BMServiceComponent.dart';

class BMOurServiveComponent extends StatefulWidget {
  @override
  State<BMOurServiveComponent> createState() => _BMOurServiveComponentState();
}

class _BMOurServiveComponentState extends State<BMOurServiveComponent> {
  @override
  Widget build(BuildContext context) {
    ShopViewModel shopViewModel = Provider.of<ShopViewModel>(context);
    print(
        "shopViewModel.selectedShop.data!.services.length: ${shopViewModel.selectedShop.data?.services}");
    List<Services>? popularServiceList =
        shopViewModel.selectedShop.data?.services?.toList();

    // print("popularServiceList: ${popularServiceList!.toString()}");

    return popularServiceList == null
        ? Center(child: Text("No services"))
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.height,
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: bmPrimaryColor.withAlpha(50),
                  borderRadius: radius(32),
                  border: Border.all(color: bmPrimaryColor),
                ),
                child: AppTextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search_sharp, color: bmPrimaryColor),
                    hintText: 'Search for Services',
                    hintStyle: secondaryTextStyle(color: bmPrimaryColor),
                  ),
                  textFieldType: TextFieldType.NAME,
                  cursorColor: bmPrimaryColor,
                ),
              ),
              16.height,
              titleText(title: 'Popular Services'),
              16.height,
              popularServiceList != null && popularServiceList.length > 0
                  ? ListView.builder(
                      itemCount: popularServiceList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return BMServiceComponent(
                          element: popularServiceList[index],
                        );
                      },
                    )
                  : Container(
                      alignment: Alignment.center,
                      child: Text(
                        'No Popular Services',
                        style: secondaryTextStyle(
                          color: bmPrimaryColor,
                          size: 16,
                        ),
                      ),
                    ),
              // SingleChildScrollView(
              //   child: Column(
              //     mainAxisSize: MainAxisSize.min,
              //     children: popularServiceList.map((element) {
              //             return BMServiceComponent(
              //               element: element,
              //             );
              //           }).toList(),
              //   ),
              // ),
              16.height,
              Row(
                children: [
                  AppButton(
                    // enabled: !authViewMode.loading,
                    disabledColor: bmPrimaryColor,
                    shapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    padding: const EdgeInsets.all(16),
                    color: bmPrimaryColor,
                    onTap: () {},
                    child: Text("Book Appointment",
                        style: boldTextStyle(color: Colors.white)),
                  ).expand(),

                  // 16.width,
                  // AppButton(
                  //   height: 40,
                  //   width: 40,
                  //   child:
                  //       Icon(Icons.qr_code_scanner_rounded, color: white),
                  //   shapeBorder: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(100)),
                  //   padding: EdgeInsets.all(16),
                  //   color: Colors.grey,
                  //   onTap: () {
                  //     //
                  //   },
                  // ),
                ],
              ),
              // titleText(title: 'Other Services'),
              // 16.height,
              // Column(
              //   mainAxisSize: MainAxisSize.min,
              //   children: otherServiceList.map((e) {
              //     return BMServiceComponent(element: e);
              //   }).toList(),
              // ),
              // 30.height,
            ],
          ).paddingSymmetric(horizontal: 16);
  }
}
