import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:expertis/data/response/status.dart';
import 'package:expertis/models/categories_model.dart';
import 'package:expertis/models/shop_model.dart';
import 'package:expertis/utils/utils.dart';
import 'package:expertis/view_model/categories_view_model.dart';
import 'package:expertis/view_model/shop_view_model.dart';
import 'package:expertis/models/user_model.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:expertis/main.dart';
import 'package:expertis/utils/BMColors.dart';
import 'package:expertis/utils/BMWidgets.dart';
import 'package:dotted_border/dotted_border.dart';

class ShopInfoEditScreen extends StatefulWidget {
  ShopModel? shop;
  String? shopId;

  ShopInfoEditScreen({Key? key, this.shopId, this.shop}) : super(key: key);

  @override
  ShopInfoEditScreenState createState() => ShopInfoEditScreenState();
}

class ShopInfoEditScreenState extends State<ShopInfoEditScreen> {
  FocusNode name = FocusNode();
  FocusNode shopId = FocusNode();
  FocusNode gender = FocusNode();

  FocusNode about = FocusNode();

  List<String> roles = ['MEN', 'WOMEN', 'UNISEX'];
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
        shop.id = value.shop?.first;
      });
    });
    shop.gender = "UNISEX";
    CategoryViewModel().fetchCategoryListApi();
  }

  @override
  void dispose() {
    setStatusBarColor(Colors.transparent);
    super.dispose();
  }

  Future<void> pickImage({ImageSource source = ImageSource.gallery}) async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(
          source: source, maxHeight: 200, maxWidth: 200);
      if (image != null) {
        shop.shopLogo = image.path;
        setState(() {
          pickedImage = File(image.path);
          isFileSelected = true;
        });
      } else {
        print('No image has been picked');
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          webImage = f;
          pickedImage = File('a');
          isFileSelected = true;
        });
      } else {
        print('No image has been picked');
      }
    } else {
      print('Something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    CategoryViewModel categoryViewModel =
        Provider.of<CategoryViewModel>(context);
    categoryViewModel.fetchCategoryListApi();
    ShopViewModel shopViewModel = Provider.of<ShopViewModel>(context);
    List<CategoryModel?> selectedTags = [];
    List<CategoryModel> categories = [
      CategoryModel(tagName: "spa"),
      CategoryModel(tagName: "salon")
    ];
    final _items = categories
        .map((animal) =>
            MultiSelectItem<CategoryModel>(animal, animal.tagName ?? ''))
        .toList();
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
              child: headerText(title: "Shop Information"),
            ),
            lowerContainer(
                screenContext: context,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      16.height,

                      Text('Shop Name',
                          style: primaryTextStyle(
                              color: appStore.isDarkModeOn
                                  ? bmTextColorDarkMode
                                  : bmSpecialColor,
                              size: 14)),
                      AppTextField(
                        keyboardType: TextInputType.text,
                        nextFocus: shopId,
                        // initialValue: shop.shopName ?? '',
                        onChanged: (value) {
                          shop.shopName = value;
                        },
                        textFieldType: TextFieldType.NAME,
                        errorThisFieldRequired: 'Name is required',
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
                      Text('Shop Logo',
                          style: primaryTextStyle(
                              color: appStore.isDarkModeOn
                                  ? bmTextColorDarkMode
                                  : bmSpecialColor,
                              size: 14)),
                      // Image to be picked code is here
                      Row(children: [
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  height: 200,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: pickedImage == null
                                      ? dottedBorder(color: Colors.grey)
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: kIsWeb
                                              ? Image.memory(webImage,
                                                  fit: BoxFit.fill,
                                                  width: 200,
                                                  height: 200)
                                              : Image.file(pickedImage!,
                                                  fit: BoxFit.fill,
                                                  width: 200,
                                                  height: 200),
                                        )),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              AppButton(
                                child: Text('Clear',
                                    style: boldTextStyle(color: Colors.red)),
                                padding: EdgeInsets.all(16),
                                width: 150,
                                onTap: () {
                                  setState(() {
                                    pickedImage = null;
                                    isFileSelected = false;
                                    webImage = Uint8List(8);
                                  });
                                },
                              ),
                              SizedBox(height: 12),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      color: appStore.isDarkModeOn
                                          ? bmTextColorDarkMode
                                          : bmPrimaryColor,
                                      icon: Icon(Icons.photo),
                                      onPressed: () {
                                        pickImage(source: ImageSource.gallery);
                                      },
                                    ),
                                    IconButton(
                                      color: appStore.isDarkModeOn
                                          ? bmTextColorDarkMode
                                          : bmPrimaryColor,
                                      icon: Icon(Icons.camera_alt),
                                      onPressed: () {
                                        pickImage(source: ImageSource.camera);
                                      },
                                    ),
                                  ]),
                              // AppButton(
                              //   shapeBorder: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(12)),
                              //   child: Text('Change',
                              //       style: boldTextStyle(color: Colors.white)),
                              //   padding: EdgeInsets.all(16),
                              //   width: 150,
                              //   color: bmPrimaryColor,
                              //   onTap: () {
                              //     // pickImage();
                              //   },
                              // ),
                            ],
                          ),
                        ),
                      ]),
                      Divider(
                        color: appStore.isDarkModeOn
                            ? bmTextColorDarkMode
                            : bmPrimaryColor,
                        thickness: 1,
                      ),
                      20.height,
                      Text('Category',
                          style: primaryTextStyle(
                              color: appStore.isDarkModeOn
                                  ? bmTextColorDarkMode
                                  : bmSpecialColor,
                              size: 14)),
                      categoryViewModel.categoryList.status == Status.LOADING
                          ? CircularProgressIndicator()
                          : MultiSelectDialogField(
                              searchable: true,
                              items: categoryViewModel
                                      .categoryList.data?.categories
                                      ?.map((e) =>
                                          MultiSelectItem(e, e.tagName ?? ''))
                                      .toList() ??
                                  [],
                              listType: MultiSelectListType.CHIP,
                              onConfirm: (values) {
                                selectedTags = values as List<CategoryModel>;
                              },
                            ),
                      20.height,

                      Text('Shop Id',
                          style: primaryTextStyle(
                              color: appStore.isDarkModeOn
                                  ? bmTextColorDarkMode
                                  : bmSpecialColor,
                              size: 14)),
                      AppTextField(
                        // initialValue: shop.shopId ?? '',
                        keyboardType: TextInputType.text,
                        nextFocus: about,
                        focus: shopId,
                        onChanged: (value) {
                          shop.shopId = value;
                        },
                        textFieldType: TextFieldType.USERNAME,
                        errorThisFieldRequired: 'Name id required',
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
                      Text('Type',
                          style: primaryTextStyle(
                              color: appStore.isDarkModeOn
                                  ? bmTextColorDarkMode
                                  : bmSpecialColor,
                              size: 14)),
                      20.height,
                      DropdownButtonFormField(
                        value: selectedRole,
                        focusNode: gender,
                        items: roles.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style: primaryTextStyle(
                                    color: appStore.isDarkModeOn
                                        ? bmTextColorDarkMode
                                        : bmSpecialColor,
                                    size: 14)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedRole = value.toString();
                          });
                          shop.gender = value.toString();
                        },
                        onSaved: ((newValue) {
                          // Utils.focusChange(context, gender, phone);
                        }),
                      ),
                      20.height,

                      // Text('Address',
                      //     style: primaryTextStyle(
                      //         color: appStore.isDarkModeOn
                      //             ? bmTextColorDarkMode
                      //             : bmSpecialColor,
                      //         size: 14)),
                      // AppTextField(
                      //   keyboardType: TextInputType.text,
                      //   focus: address,
                      //   // initialValue: shop.contact?.address ?? '',
                      //   nextFocus: pinCode,
                      //   textFieldType: TextFieldType.NAME,
                      //   onChanged: (p0) {
                      //     shop.contact == null
                      //         ? shop.contact = Contact(address: p0)
                      //         : shop.contact?.address = p0;
                      //   },

                      //   // controller: _addressController,
                      //   errorThisFieldRequired: 'Address is required',
                      //   cursorColor: bmPrimaryColor,
                      //   textStyle: boldTextStyle(
                      //       color: appStore.isDarkModeOn
                      //           ? bmTextColorDarkMode
                      //           : bmPrimaryColor),
                      //   decoration: InputDecoration(
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
                      // 20.height,
                      // Text('Pin Code',
                      //     style: primaryTextStyle(
                      //         color: appStore.isDarkModeOn
                      //             ? bmTextColorDarkMode
                      //             : bmSpecialColor,
                      //         size: 14)),
                      // AppTextField(
                      //   focus: pinCode,
                      //   textFieldType: TextFieldType.PHONE,
                      //   autoFocus: true,
                      //   nextFocus: about,
                      //   // initialValue: shop.contact?.pinCode.toString() ?? '',
                      //   onChanged: (p0) => shop.contact == null
                      //       ? shop.contact = Contact(pinCode: p0.toInt())
                      //       : shop.contact?.pinCode = p0.toInt(),
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
                      20.height,
                      Text('About Shop',
                          style: primaryTextStyle(
                              color: appStore.isDarkModeOn
                                  ? bmTextColorDarkMode
                                  : bmSpecialColor,
                              size: 14)),
                      AppTextField(
                        keyboardType: TextInputType.multiline,
                        focus: about,
                        // initialValue: shop.contact?.address ?? '',
                        nextFocus: null,
                        textFieldType: TextFieldType.MULTILINE,
                        onChanged: (p0) {
                          shop.about = p0;
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

                      30.height,
                      AppButton(
                        width: context.width() - 32,
                        shapeBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32)),
                        padding: const EdgeInsets.all(16),
                        color: bmPrimaryColor,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            if (!kIsWeb) {
                              if (pickedImage == null) {
                                Utils.flushBarErrorMessage(
                                    "Please pic a shop logo", context);
                                return;
                              }
                            }

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
                            shopViewModel.sendShopData(
                                false, data, isFileSelected, files, context);
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
