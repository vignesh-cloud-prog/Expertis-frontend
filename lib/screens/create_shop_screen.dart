import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:beamer/beamer.dart';
import 'package:expertis/models/shop_model.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/utils/utils.dart';
import 'package:expertis/view_model/shop_view_model.dart';
import 'package:expertis/models/user_model.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:expertis/main.dart';
import 'package:expertis/utils/BMColors.dart';
import 'package:expertis/utils/BMWidgets.dart';
import 'package:dotted_border/dotted_border.dart';

class CreateShopScreen extends StatefulWidget {
  const CreateShopScreen({
    Key? key,
  }) : super(key: key);

  @override
  CreateShopScreenState createState() => CreateShopScreenState();
}

class CreateShopScreenState extends State<CreateShopScreen> {
  FocusNode name = FocusNode();
  FocusNode shopId = FocusNode();
  FocusNode gender = FocusNode();
  FocusNode email = FocusNode();
  FocusNode phone = FocusNode();
  FocusNode address = FocusNode();
  FocusNode about = FocusNode();
  FocusNode pinCode = FocusNode();
  FocusNode dob = FocusNode();
  List<String> roles = ['MALE', 'FEMALE', 'UNISEX'];
  UserModel? user;
  String selectedRole = 'UNISEX';

  String? selectedGender;
  bool isFileSelected = false;
  File? pickedImage;
  Uint8List webImage = Uint8List(8);
  ShopModel shop = ShopModel();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _dobController = TextEditingController();

  @override
  void initState() {
    setStatusBarColor(bmSpecialColor);
    super.initState();
    UserViewModel.getUser().then((value) {
      setState(() {
        shop.owner = value.id;
      });
    });
    shop.gender = "UNISEX";
  }

  @override
  void dispose() {
    setStatusBarColor(Colors.transparent);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ShopViewModel shopViewModel = Provider.of<ShopViewModel>(context);
    // print(shop.toJson());
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn
          ? appStore.scaffoldBackground!
          : bmLightScaffoldBackgroundColor,
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            upperContainer(
              screenContext: context,
              child: headerText(title: "Register Shop"),
            ),
            lowerContainer(
                screenContext: context,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      25.height,
                      Text('Shop Id',
                          style: primaryTextStyle(
                              color: appStore.isDarkModeOn
                                  ? bmTextColorDarkMode
                                  : bmSpecialColor,
                              size: 14)),
                      AppTextField(
                        // initialValue: shop.shopId ?? '',
                        keyboardType: TextInputType.text,
                        nextFocus: email,
                        focus: shopId,
                        onChanged: (value) {
                          shop.shopId = value;
                        },
                        textFieldType: TextFieldType.USERNAME,
                        errorThisFieldRequired: 'Shop id is required',
                        autoFocus: true,
                        cursorColor: bmPrimaryColor,
                        textStyle: boldTextStyle(
                            color: appStore.isDarkModeOn
                                ? bmTextColorDarkMode
                                : bmPrimaryColor),
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: appStore.isDarkModeOn
                                      ? bmTextColorDarkMode
                                      : bmPrimaryColor)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: appStore.isDarkModeOn
                                      ? bmTextColorDarkMode
                                      : bmPrimaryColor)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: appStore.isDarkModeOn
                                      ? bmTextColorDarkMode
                                      : bmPrimaryColor)),
                        ),
                      ),
                      20.height,
                      Text('Email',
                          style: primaryTextStyle(
                              color: appStore.isDarkModeOn
                                  ? bmTextColorDarkMode
                                  : bmSpecialColor,
                              size: 14)),
                      AppTextField(
                        keyboardType: TextInputType.emailAddress,
                        nextFocus: phone,
                        focus: email,
                        textFieldType: TextFieldType.EMAIL,
                        // initialValue: shop.contact!.email ?? '',
                        onChanged: (value) {
                          shop.contact == null
                              ? shop.contact = Contact(email: value)
                              : shop.contact?.email = value;
                        },
                        errorInvalidEmail: 'Invalid email',
                        errorThisFieldRequired: 'Email is required',
                        autoFocus: true,
                        cursorColor: bmPrimaryColor,
                        textStyle: boldTextStyle(
                            color: appStore.isDarkModeOn
                                ? bmTextColorDarkMode
                                : bmPrimaryColor),
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: appStore.isDarkModeOn
                                      ? bmTextColorDarkMode
                                      : bmPrimaryColor)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: appStore.isDarkModeOn
                                      ? bmTextColorDarkMode
                                      : bmPrimaryColor)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: appStore.isDarkModeOn
                                      ? bmTextColorDarkMode
                                      : bmPrimaryColor)),
                        ),
                      ),
                      20.height,
                      Text('Phone number',
                          style: primaryTextStyle(
                              color: appStore.isDarkModeOn
                                  ? bmTextColorDarkMode
                                  : bmSpecialColor,
                              size: 14)),
                      AppTextField(
                        focus: phone,
                        // initialValue: shop.contact?.phone.toString() ?? '',
                        textFieldType: TextFieldType.PHONE,
                        nextFocus: address,
                        maxLength: 10,
                        onChanged: (p0) => shop.contact == null
                            ? shop.contact = Contact(phone: p0.toInt())
                            : shop.contact?.phone = p0.toInt(),
                        // controller: _phoneController,
                        validator: (value) {
                          Pattern pattern =
                              r'^(\+91[\-\s]?)?[0]?(91)?[789]\d{9}$';
                          RegExp regex = RegExp(pattern.toString());

                          if (value!.length != 10) {
                            return 'Phone number must be 10 digits';
                          } else if (!regex.hasMatch(value)) {
                            return 'Invalid phone number';
                          }
                          return null;
                        },
                        errorThisFieldRequired: 'Phone number is required',
                        cursorColor: bmPrimaryColor,
                        textStyle: boldTextStyle(
                            color: appStore.isDarkModeOn
                                ? bmTextColorDarkMode
                                : bmPrimaryColor),
                        suffixIconColor: bmPrimaryColor,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: appStore.isDarkModeOn
                                      ? bmTextColorDarkMode
                                      : bmPrimaryColor)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: appStore.isDarkModeOn
                                      ? bmTextColorDarkMode
                                      : bmPrimaryColor)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: appStore.isDarkModeOn
                                      ? bmTextColorDarkMode
                                      : bmPrimaryColor)),
                        ),
                      ),
                      30.height,
                      AppButton(
                        width: context.width() - 32,
                        shapeBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32)),
                        padding: const EdgeInsets.all(16),
                        color: bmPrimaryColor,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            if (kDebugMode) {
                              print("form is valid");
                              print('shop name: ${shop.contact?.email}');
                              print(shop);
                              print(shop.toJson());
                            }

                            Map shopData = shop.toJson()
                              ..removeWhere((key, value) =>
                                  key == 'id' ||
                                  value == null ||
                                  value == '' ||
                                  value == 'null');
                            print('map: $shopData');

                            Map<String, String> data = shopData
                                .map((k, v) => MapEntry(k, v.toString()));

                            data['phone'] =
                                shop.contact?.phone.toString() ?? '';
                            data['email'] = shop.contact?.email ?? '';
                            Map<String, dynamic?> files = {
                              'shopLogo': shop.shopLogo,
                            };
                            data.remove('shopLogo');
                            data.remove('contact');
                            shopViewModel.sendShopData(false, data,
                                isFileSelected, false, files, context);
                          }
                        },
                        child: shopViewModel.loading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text('Register',
                                style: boldTextStyle(color: Colors.white)),
                      ),
                      20.height,
                      Text('SKIP',
                              style:
                                  boldTextStyle(color: bmGreyColor, size: 14))
                          .center()
                          .onTap(() {
                        Beamer.of(context)
                            .beamToReplacementNamed(RoutesName.home);
                      }),
                      30.height,
                    ],
                  ).paddingSymmetric(horizontal: 16),
                )).expand()
          ],
        ),
      ),
    );
  }

  Widget dottedBorder({
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DottedBorder(
          dashPattern: const [6.7],
          borderType: BorderType.RRect,
          color: color,
          radius: const Radius.circular(12),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Drag and drop image here',
                  style: boldTextStyle(
                    color: color,
                    size: 14,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
