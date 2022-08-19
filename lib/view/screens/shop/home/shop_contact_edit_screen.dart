import 'package:expertis/models/shop_model.dart';
import 'package:expertis/view_model/categories_view_model.dart';
import 'package:expertis/view_model/shop_view_model.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:expertis/main.dart';
import 'package:expertis/utils/BMColors.dart';
import 'package:expertis/utils/BMWidgets.dart';
import 'package:dotted_border/dotted_border.dart';

class ShopContactEditScreen extends StatefulWidget {
  ShopModel? shop;
  String? shopId;
  bool isAdmin;

  ShopContactEditScreen(
      {Key? key, this.shopId, this.shop, this.isAdmin = false})
      : super(key: key);

  @override
  ShopContactEditScreenState createState() => ShopContactEditScreenState();
}

class ShopContactEditScreenState extends State<ShopContactEditScreen> {
  FocusNode name = FocusNode();
  FocusNode shopId = FocusNode();
  FocusNode gender = FocusNode();

  FocusNode about = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    setStatusBarColor(bmSpecialColor);

    widget.shop ??= ShopModel();

    super.initState();
  }

  @override
  void dispose() {
    setStatusBarColor(Colors.transparent);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isAdmin)
      UserViewModel.getUser().then((value) {
        widget.shop?.id = value.shop?.first.id;
        widget.shop?.owner = value.id;
      });

    ShopViewModel shopViewModel = Provider.of<ShopViewModel>(context);

    return Scaffold(
      backgroundColor: appStore.isDarkModeOn
          ? appStore.scaffoldBackground!
          : bmLightScaffoldBackgroundColor,
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            appBar(context, "Shop Contact Details"),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.height,
                  Text('Email address',
                      style: primaryTextStyle(
                          color: appStore.isDarkModeOn
                              ? bmTextColorDarkMode
                              : bmSpecialColor,
                          size: 14)),
                  AppTextField(
                    keyboardType: TextInputType.emailAddress,
                    // nextFocus: phone,
                    // focus: email,
                    textFieldType: TextFieldType.EMAIL,
                    initialValue: widget.shop?.contact?.email ?? '',
                    onChanged: (value) {
                      widget.shop?.contact == null
                          ? widget.shop?.contact = Contact(email: value)
                          : widget.shop?.contact?.email = value;
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
                    // focus: phone,
                    initialValue: widget.shop?.contact?.phone.toString() ?? '',
                    textFieldType: TextFieldType.PHONE,
                    // nextFocus: address,
                    maxLength: 10,
                    onChanged: (p0) => widget.shop?.contact == null
                        ? widget.shop?.contact = Contact(phone: p0.toInt())
                        : widget.shop?.contact?.phone = p0.toInt(),
                    // controller: _phoneController,
                    validator: (value) {
                      Pattern pattern = r'^(\+91[\-\s]?)?[0]?(91)?[789]\d{9}$';
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
                  Text('Address',
                      style: primaryTextStyle(
                          color: appStore.isDarkModeOn
                              ? bmTextColorDarkMode
                              : bmSpecialColor,
                          size: 14)),
                  AppTextField(
                    keyboardType: TextInputType.text,
                    // focus: address,
                    initialValue: widget.shop?.contact?.address ?? '',
                    // nextFocus: pinCode,
                    textFieldType: TextFieldType.NAME,
                    onChanged: (p0) {
                      widget.shop?.contact == null
                          ? widget.shop?.contact = Contact(address: p0)
                          : widget.shop?.contact?.address = p0;
                    },

                    // controller: _addressController,
                    errorThisFieldRequired: 'Address is required',
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
                  Text('Pin Code',
                      style: primaryTextStyle(
                          color: appStore.isDarkModeOn
                              ? bmTextColorDarkMode
                              : bmSpecialColor,
                          size: 14)),
                  AppTextField(
                    keyboardType: TextInputType.text,
                    // focus: address,
                    initialValue:
                        widget.shop?.contact?.pinCode.toString() != "null"
                            ? widget.shop?.contact?.pinCode.toString()
                            : '',
                    // nextFocus: pinCode,
                    maxLength: 6,
                    textFieldType: TextFieldType.NAME,
                    onChanged: (p0) {
                      widget.shop?.contact == null
                          ? widget.shop?.contact = Contact(pinCode: p0.toInt())
                          : widget.shop?.contact?.pinCode = p0.toInt();
                    },

                    // controller: _addressController,
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
                  Text('Online Presence',
                      style: primaryTextStyle(
                          color: appStore.isDarkModeOn
                              ? bmTextColorDarkMode
                              : bmSpecialColor,
                          size: 14)),
                  20.height,
                  AppTextField(
                    isValidationRequired: false,
                    textFieldType: TextFieldType.PHONE,
                    autoFocus: true,
                    nextFocus: about,
                    initialValue:
                        widget.shop?.contact?.whatsapp.toString() != "null"
                            ? widget.shop?.contact?.whatsapp.toString()
                            : '',
                    onChanged: (p0) => widget.shop?.contact == null
                        ? widget.shop?.contact = Contact(whatsapp: p0)
                        : widget.shop?.contact?.whatsapp = p0,
                    // controller: _pinCodeController,
                    validator: (value) {
                      if (value!.length != 10) {
                        return 'Whatsapp number must be greater than 9 digits';
                      }
                      return null;
                    },
                    // errorThisFieldRequired: 'Pin code is required',
                    maxLength: 13,
                    cursorColor: bmPrimaryColor,
                    textStyle: boldTextStyle(
                        color: appStore.isDarkModeOn
                            ? bmTextColorDarkMode
                            : bmPrimaryColor),
                    suffixIconColor: bmPrimaryColor,
                    decoration: InputDecoration(
                      hintText: 'WhatsApp',
                      prefixIcon: const Icon(
                        Icons.whatsapp,
                        color: bmPrimaryColor,
                      ),
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
                  AppTextField(
                    isValidationRequired: false,
                    keyboardType: TextInputType.text,
                    // focus: address,
                    initialValue: widget.shop?.contact?.website ?? '',
                    // nextFocus: pinCode,
                    textFieldType: TextFieldType.URL,
                    onChanged: (p0) {
                      widget.shop?.contact == null
                          ? widget.shop?.contact = Contact(website: p0)
                          : widget.shop?.contact?.website = p0;
                    },

                    // controller: _addressController,
                    cursorColor: bmPrimaryColor,
                    textStyle: boldTextStyle(
                        color: appStore.isDarkModeOn
                            ? bmTextColorDarkMode
                            : bmPrimaryColor),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.edit_location_alt_outlined,
                        color: bmPrimaryColor,
                      ),
                      hintText: 'Shop location link',
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
                  AppTextField(
                    isValidationRequired: false,
                    keyboardType: TextInputType.text,
                    // focus: address,
                    initialValue: widget.shop?.contact?.website ?? '',
                    // nextFocus: pinCode,
                    textFieldType: TextFieldType.URL,
                    onChanged: (p0) {
                      widget.shop?.contact == null
                          ? widget.shop?.contact = Contact(website: p0)
                          : widget.shop?.contact?.website = p0;
                    },

                    // controller: _addressController,
                    cursorColor: bmPrimaryColor,
                    textStyle: boldTextStyle(
                        color: appStore.isDarkModeOn
                            ? bmTextColorDarkMode
                            : bmPrimaryColor),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.web,
                        color: bmPrimaryColor,
                      ),
                      hintText: 'Website',
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
                  AppTextField(
                    isValidationRequired: false,
                    keyboardType: TextInputType.text,
                    // focus: address,
                    initialValue: widget.shop?.contact?.facebook ?? '',
                    // nextFocus: pinCode,
                    textFieldType: TextFieldType.URL,
                    onChanged: (p0) {
                      widget.shop?.contact == null
                          ? widget.shop?.contact = Contact(facebook: p0)
                          : widget.shop?.contact?.facebook = p0;
                    },

                    // controller: _addressController,
                    cursorColor: bmPrimaryColor,
                    textStyle: boldTextStyle(
                        color: appStore.isDarkModeOn
                            ? bmTextColorDarkMode
                            : bmPrimaryColor),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        FeatherIcons.facebook,
                        color: bmPrimaryColor,
                      ),
                      hintText: 'Facebook',
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
                  AppTextField(
                    isValidationRequired: false,
                    keyboardType: TextInputType.text,
                    // focus: address,
                    initialValue: widget.shop?.contact?.instagram ?? '',
                    // nextFocus: pinCode,
                    textFieldType: TextFieldType.URL,
                    onChanged: (p0) {
                      widget.shop?.contact == null
                          ? widget.shop?.contact = Contact(instagram: p0)
                          : widget.shop?.contact?.instagram = p0;
                    },

                    // controller: _addressController,
                    cursorColor: bmPrimaryColor,
                    textStyle: boldTextStyle(
                        color: appStore.isDarkModeOn
                            ? bmTextColorDarkMode
                            : bmPrimaryColor),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        FeatherIcons.instagram,
                        color: bmPrimaryColor,
                      ),
                      hintText: 'Instagram',
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
                  AppTextField(
                    isValidationRequired: false,
                    keyboardType: TextInputType.text,
                    // focus: address,
                    initialValue: widget.shop?.contact?.twitter ?? '',
                    // nextFocus: pinCode,
                    textFieldType: TextFieldType.URL,
                    onChanged: (p0) {
                      widget.shop?.contact == null
                          ? widget.shop?.contact = Contact(twitter: p0)
                          : widget.shop?.contact?.twitter = p0;
                    },

                    // controller: _addressController,
                    cursorColor: bmPrimaryColor,
                    textStyle: boldTextStyle(
                        color: appStore.isDarkModeOn
                            ? bmTextColorDarkMode
                            : bmPrimaryColor),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        FeatherIcons.twitter,
                        color: bmPrimaryColor,
                      ),
                      hintText: 'Twitter',
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
                          // print('shop name: ${widget.shop?.contact?.email}');
                          print(widget.shop?.shopId);
                          print(widget.shop?.toJson());
                        }

                        Map shopContactData = widget.shop!.contact!.toJson()
                          ..removeWhere((key, value) =>
                              value == null || value == '' || value == 'null');
                        shopContactData["owner"] = widget.shop?.owner;
                        shopContactData["id"] = widget.shop?.id;
                        print('map: $shopContactData');

                        Map<String, String> data = shopContactData
                            .map((k, v) => MapEntry(k, v.toString()));

                        Map<String, dynamic?> files = {
                          'shopLogo': widget.shop?.shopLogo,
                        };

                        data.remove('shopLogo');
                        data.remove('tags');
                        shopViewModel.sendShopData(
                            true, data, false, widget.isAdmin, files, context);
                      }
                    },
                    child: shopViewModel.loading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text('Submit',
                            style: boldTextStyle(color: Colors.white)),
                  ),
                  30.height,
                ],
              ).paddingSymmetric(horizontal: 16),
            ).expand()
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
