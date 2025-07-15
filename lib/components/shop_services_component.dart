import 'package:beamer/beamer.dart';
import 'package:expertis/main.dart';
import 'package:expertis/models/shop_model.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/utils/assets.dart';
import 'package:expertis/view_model/appointment_list_view_model.dart';
import 'package:expertis/view_model/shop_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../utils/BMColors.dart';
import '../utils/BMWidgets.dart';
import 'select_services_component.dart';

class ShopServiceComponent extends StatefulWidget {
  const ShopServiceComponent({Key? key}) : super(key: key);

  @override
  State<ShopServiceComponent> createState() => _ShopServiceComponentState();
}

class _ShopServiceComponentState extends State<ShopServiceComponent> {
  @override
  Widget build(BuildContext context) {
    AppointmentListViewModel appointmentViewModel =
        Provider.of<AppointmentListViewModel>(context);
    appointmentViewModel.appointmentModel.selectedServices = [];
    ShopViewModel shopViewModel = Provider.of<ShopViewModel>(context);
    // print(
    //     "shopViewModel.selectedShop.data!.services.length: ${shopViewModel.selectedShop.data?.services}");
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
              titleText(title: 'Our Services'),
              16.height,
              popularServiceList.length > 0
                  ? ListView.builder(
                      itemCount: popularServiceList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return SelectServiceComponent(
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
                    onTap: () {
                      List<Members>? members =
                          shopViewModel.selectedShop.data?.members?.toList();
                      String? shopId = shopViewModel.selectedShop.data?.id;
                      showSelectStaffBottomSheet(context, members, shopId);
                    },
                    child: Text("Book Appointment Now",
                        style: boldTextStyle(color: Colors.white)),
                  ).expand(),
                ],
              ),
            ],
          ).paddingSymmetric(horizontal: 16);
  }

  void showSelectStaffBottomSheet(
      BuildContext context, List<Members>? element, String? shopId) {
    AppointmentListViewModel appointmentViewModel =
        Provider.of<AppointmentListViewModel>(context, listen: false);
    // List<BMMasterModel> myMasterList = getMyMastersList();

    int selectedTab = 0;
    appointmentViewModel.appointmentModel.memberId =
        element?[selectedTab].member;

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: true,
        isDismissible: true,
        shape: RoundedRectangleBorder(
            borderRadius: radiusOnly(topLeft: 30, topRight: 30)),
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      finish(context);
                    },
                    icon: const Icon(Icons.cancel_rounded,
                        color: bmTextColorDarkMode),
                  ),
                ),
                titleText(title: 'Select Staff', size: 24),
                16.height,
                Wrap(
                  children: element!.map((e) {
                    int index = element.indexOf(e);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.network(e.pic ?? Assets.defaultServiceImage,
                                    height: 40, width: 40, fit: BoxFit.cover)
                                .cornerRadiusWithClipRRect(100),
                            8.width,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(e.name ?? '',
                                    style: boldTextStyle(
                                        color: appStore.isDarkModeOn
                                            ? white
                                            : black,
                                        size: 18)),
                                Text(e.role ?? '',
                                    style: primaryTextStyle(
                                        color: appStore.isDarkModeOn
                                            ? white
                                            : bmSpecialColorDark)),
                              ],
                            ).paddingAll(8),
                          ],
                        ),
                        IconButton(
                          icon: selectedTab == index
                              ? const Icon(Icons.check_circle,
                                  color: bmPrimaryColor)
                              : const Icon(Icons.circle_outlined,
                                  color: bmPrimaryColor),
                          onPressed: () {
                            selectedTab = index;
                            appointmentViewModel.appointmentModel.memberId =
                                element[index].member;
                            ;
                            setState(() {});
                          },
                        ),
                      ],
                    );
                  }).toList(),
                ),
                50.height,
                AppButton(
                  shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  color: bmPrimaryColor,
                  onTap: () {
                    String date =
                        DateFormat('dd-MMM-yyyy').format(DateTime.now());
                    // print(date);
                    Provider.of<ShopViewModel>(context, listen: false)
                        .fetchSlotsApi(
                      shopId,
                      element[selectedTab].member,
                      date,
                    );
                    print("member id: ${element[selectedTab].member}");
                    Beamer.of(context).beamToNamed(
                        RoutesName.bookAppointmentWithId(
                            shopId, element[selectedTab].member));
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.event_available, color: Colors.white),
                      6.width,
                      Text('Check Availability',
                          style: boldTextStyle(color: Colors.white)),
                    ],
                  ),
                ).center(),
                30.height,
              ],
            ).paddingAll(16);
          });
        });
  }
}
