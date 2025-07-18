import 'package:expertis/utils/assets.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../utils/BMColors.dart';
import '../utils/BMWidgets.dart';

class HomeFragmentHeadComponent extends StatefulWidget {
  const HomeFragmentHeadComponent({super.key});

  @override
  State<HomeFragmentHeadComponent> createState() =>
      _HomeFragmentHeadComponentState();
}

class _HomeFragmentHeadComponentState extends State<HomeFragmentHeadComponent> {
  @override
  Widget build(BuildContext context) {
    UserViewModel? userViewModel = Provider.of<UserViewModel>(context);

    return SizedBox(
        width: double.infinity,
        height: 180.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.network(
                  userViewModel.user?.userPic == "null" ||
                          userViewModel.user?.userPic == ""
                      ? Assets.defaultUserImage
                      : userViewModel.user?.userPic ?? Assets.defaultUserImage,
                  height: 60,
                  width: 60,
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                      'assets/image-not-found.jpg',
                      fit: BoxFit.cover,
                      height: 60,
                      width: 60),
                ).cornerRadiusWithClipRRect(100),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleText(
                      title: "Welcome",
                      size: 20,
                    ),
                    Text(userViewModel.user!.name,
                        style: kTitleStyle.copyWith(color: Colors.white)),
                  ],
                )
              ],
            ),
            6.height,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: const Row(children: [
                        Icon(
                          Icons.location_city,
                          color: bmPrimaryColor,
                        ),
                        Text("City", style: TextStyle(color: white)),
                      ]),
                    ),
                    5.width,
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: AppTextField(
                        textFieldType: TextFieldType.NAME,
                        initialValue: userViewModel.user?.address ?? "",
                      ),
                    ),
                    // 5.width,
                    // Icon(
                    //   Icons.edit,
                    //   color: bmPrimaryColor,
                    // ),
                  ],
                ),
                4.height,
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: const Row(children: [
                        Icon(
                          Icons.numbers,
                          color: bmPrimaryColor,
                        ),
                        Text("Pin Code", style: TextStyle(color: white)),
                      ]),
                    ),
                    5.width,
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: AppTextField(
                        suffix: const Icon(
                          Icons.edit,
                          color: bmPrimaryColor,
                        ),
                        textFieldType: TextFieldType.PHONE,
                        initialValue: userViewModel.user?.pinCode ?? "",
                      ),
                    ),
                    // 5.width,
                    // Icon(
                    //   Icons.edit,
                    //   color: bmPrimaryColor,
                    // ),
                  ],
                ),

                // AppTextField(
                //   // focus: pinCode,
                //   textFieldType: TextFieldType.PHONE,
                //   // nextFocus: dob,
                //   // initialValue: userViewModel.user?.pinCode.toString() == "null"
                //   // ? ""
                //   // : userViewModel.user?.pinCode,
                //   onChanged: (value) {},
                //   // controller: _pinCodeController,
                //   validator: (value) {
                //     if (value!.length != 6) {
                //       return 'Pin code must be 6 digits';
                //     }
                //     return null;
                //   },
                //   errorThisFieldRequired: 'Pin code is required',
                //   maxLength: 6,
                //   cursorColor: bmPrimaryColor,
                //   textStyle: boldTextStyle(
                //       color: appStore.isDarkModeOn
                //           ? bmTextColorDarkMode
                //           : bmPrimaryColor),
                //   suffixIconColor: bmPrimaryColor,
                //   decoration: InputDecoration(
                //     prefix: Row(children: [
                //       Icon(
                //         Icons.numbers,
                //         color: bmPrimaryColor,
                //       ),
                //       Text("Pin Code")
                //     ]),
                //     border: UnderlineInputBorder(
                //         borderSide: BorderSide(
                //             color: appStore.isDarkModeOn
                //                 ? bmTextColorDarkMode
                //                 : bmPrimaryColor)),
                //     focusedBorder: UnderlineInputBorder(
                //         borderSide: BorderSide(
                //             color: appStore.isDarkModeOn
                //                 ? bmTextColorDarkMode
                //                 : bmPrimaryColor)),
                //     enabledBorder: UnderlineInputBorder(
                //         borderSide: BorderSide(
                //             color: appStore.isDarkModeOn
                //                 ? bmTextColorDarkMode
                //                 : bmPrimaryColor)),
                //   ),
                // ),
              ],
            ).paddingOnly(left: 20),
            // AppTextField(
            //   keyboardType: TextInputType.text,
            //   // focus: address,
            //   // initialValue: userViewModel.user?.address ?? "",
            //   // nextFocus: pinCode,
            //   textFieldType: TextFieldType.NAME,
            //   onChanged: (value) {},
            //   // controller: _addressController,
            //   errorThisFieldRequired: 'City name is required',
            //   cursorColor: bmPrimaryColor,
            //   textStyle: boldTextStyle(
            //       color: appStore.isDarkModeOn
            //           ? bmTextColorDarkMode
            //           : bmPrimaryColor),
            //   decoration: InputDecoration(
            //     prefix: Row(children: [
            //       Icon(
            //         Icons.location_city,
            //         color: bmPrimaryColor,
            //       ),
            //       Text("City")
            //     ]),
            //     border: UnderlineInputBorder(
            //         borderSide: BorderSide(
            //             color: appStore.isDarkModeOn
            //                 ? bmTextColorDarkMode
            //                 : bmPrimaryColor)),
            //     focusedBorder: UnderlineInputBorder(
            //         borderSide: BorderSide(
            //             color: appStore.isDarkModeOn
            //                 ? bmTextColorDarkMode
            //                 : bmPrimaryColor)),
            //     enabledBorder: UnderlineInputBorder(
            //         borderSide: BorderSide(
            //             color: appStore.isDarkModeOn
            //                 ? bmTextColorDarkMode
            //                 : bmPrimaryColor)),
            //   ),
            // ),
          ],
        ));
  }
}
