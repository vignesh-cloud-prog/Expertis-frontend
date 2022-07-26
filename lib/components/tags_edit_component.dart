import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:expertis/models/categories_model.dart';
import 'package:expertis/utils/utils.dart';
import 'package:expertis/view_model/categories_view_model.dart';
import 'package:expertis/widgets/text_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../utils/BMColors.dart';
import '../utils/BMWidgets.dart';
import 'package:dotted_border/dotted_border.dart';

class EditTagComponent extends StatefulWidget {
  final String title;
  final String buttonName;

  const EditTagComponent(
      {Key? key, this.title = "Create Tag", this.buttonName = "Create"})
      : super(key: key);

  @override
  _EditTagComponentState createState() => _EditTagComponentState();
}

class _EditTagComponentState extends State<EditTagComponent> {
  FocusNode description = FocusNode();

  String? selectedGender;
  bool isFileSelected = false;
  File? pickedImage;
  PlatformFile? file;

  Uint8List webImage = Uint8List(8);
  CategoryModel category = CategoryModel();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    setStatusBarColor(bmSpecialColor);
    super.initState();
  }

  @override
  void dispose() {
    setStatusBarColor(Colors.transparent);
    super.dispose();
  }

  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      file = result.files.first;
      if (!kIsWeb) {
        setState(() {
          pickedImage = File(file?.path ?? '');
          isFileSelected = true;
        });
      } else if (kIsWeb) {
        var f = file != null ? file?.bytes : null;
        setState(() {
          webImage = f ?? Uint8List(8);
          pickedImage = File('a');
          isFileSelected = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    CategoryViewModel categoryViewModel =
        Provider.of<CategoryViewModel>(context, listen: false);
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
              child: headerText(title: widget.title),
            ),
            lowerContainer(
                screenContext: context,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      16.height,

                      Text('Tag Name',
                          style: primaryTextStyle(
                              color: appStore.isDarkModeOn
                                  ? bmTextColorDarkMode
                                  : bmSpecialColor,
                              size: 14)),
                      AppTextField(
                        keyboardType: TextInputType.text,
                        nextFocus: description,
                        // initialValue: shop.shopName ?? '',

                        onChanged: (value) {
                          category.tagName = value;
                        },
                        textFieldType: TextFieldType.NAME,
                        errorThisFieldRequired: 'Tag Name is required',
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
                      Text('Tag Photo',
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
                              AppButton(
                                shapeBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                child: Text('Change',
                                    style: boldTextStyle(color: Colors.white)),
                                padding: EdgeInsets.all(16),
                                width: 150,
                                color: bmPrimaryColor,
                                onTap: () {
                                  pickImage();
                                },
                              ),
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

                      Text('Tag Description',
                          style: primaryTextStyle(
                              color: appStore.isDarkModeOn
                                  ? bmTextColorDarkMode
                                  : bmSpecialColor,
                              size: 14)),
                      AppTextField(
                        // initialValue: shop.shopId ?? '',
                        keyboardType: TextInputType.multiline,
                        onChanged: (value) {
                          category.description = value;
                        },
                        focus: description,
                        textFieldType: TextFieldType.MULTILINE,
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
                            if (pickedImage == null) {
                              Utils.flushBarErrorMessage(
                                  "Please pic a shop logo", context);
                              return;
                            }

                            if (kDebugMode) {
                              print("form is valid");
                              print('shop name: ${category.tagName}');
                              print(category);
                              print(category.toJson());
                            }

                            Map categoryData = category.toJson() as Map
                              ..removeWhere((key, value) =>
                                  key == null ||
                                  value == null ||
                                  value == '' ||
                                  value == 'null');
                            print('map: $categoryData');

                            Map<String, String> data = categoryData
                                .map((k, v) => MapEntry(k, v.toString()));
                            Map<String, dynamic?> files = {
                              'tagPic': file,
                            };
                            data.remove('tagPic');

                            print('data: $data');
                            print('files: $files');
                            categoryViewModel.sendTagData(
                                false, data, isFileSelected, files, context);
                          }
                        },
                        child: categoryViewModel.loading
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
                Icon(
                  Icons.image_outlined,
                  color: color,
                  size: 50,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: (() {
                      pickImage();
                    }),
                    child: TextWidget(
                      text: 'Choose an image',
                      color: Colors.blue,
                    ))
              ],
            ),
          )),
    );
  }
}
