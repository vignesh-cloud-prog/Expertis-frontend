import 'dart:io';
import 'package:expertis/models/categories_model.dart';
import 'package:expertis/utils/assets.dart';
import 'package:expertis/utils/utils.dart';
import 'package:expertis/view_model/categories_view_model.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:expertis/main.dart';
import 'package:expertis/utils/BMColors.dart';
import 'package:expertis/utils/BMWidgets.dart';
import 'package:dotted_border/dotted_border.dart';

class CreateUpdateTagScreen extends StatefulWidget {
  final String? tagId;
  CategoryModel? category;

  CreateUpdateTagScreen({super.key, this.tagId, this.category});

  @override
  CreateUpdateTagScreenState createState() => CreateUpdateTagScreenState();
}

class CreateUpdateTagScreenState extends State<CreateUpdateTagScreen> {
  FocusNode description = FocusNode();

  bool isFileSelected = false;
  File? pickedImage;
  Uint8List webImage = Uint8List(8);

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    setStatusBarColor(bmSpecialColor);
    super.initState();

    widget.category ??= CategoryModel();
  }

  @override
  void dispose() {
    setStatusBarColor(Colors.transparent);
    super.dispose();
  }

  Future<void> pickImage({ImageSource source = ImageSource.gallery}) async {
    if (!kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(
          source: source, maxHeight: 200, maxWidth: 200);
      if (image == null) {
        return;
      }
      // final newImage = await File(image.path).copy(imageFile.path);
      setState(() => widget.category?.tagPic = image.path);

      setState(() {
        isFileSelected = true;
        pickedImage = File(image.path);
      });
    } else if (kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: source);
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
    CategoryViewModel categoryViewModel = Provider.of<CategoryViewModel>(
      context,
    );

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
              child: headerText(
                  title: widget.tagId == null
                      ? 'Create Category'
                      : 'Update Category'),
            ),
            lowerContainer(
                screenContext: context,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      16.height,

                      Text('Category Name',
                          style: primaryTextStyle(
                              color: appStore.isDarkModeOn
                                  ? bmTextColorDarkMode
                                  : bmSpecialColor,
                              size: 14)),
                      AppTextField(
                        keyboardType: TextInputType.text,
                        nextFocus: description,
                        maxLength: 50,
                        initialValue: widget.category?.tagName ?? '',
                        onChanged: (value) {
                          widget.category!.tagName = value;
                          print(widget.category?.tagName);
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
                      Text('Tag Picture',
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
                                  child: isFileSelected == false &&
                                          widget.category?.tagPic != null &&
                                          widget.category?.tagPic != ""
                                      ? Image.network(
                                          widget.category?.tagPic ??
                                              Assets.defaultCategoryImage,
                                          fit: BoxFit.fill,
                                          width: 200,
                                          height: 200)
                                      : pickedImage == null
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
                                padding: const EdgeInsets.all(16),
                                width: 150,
                                onTap: () {
                                  setState(() {
                                    pickedImage = null;
                                    isFileSelected = false;
                                    webImage = Uint8List(8);
                                  });
                                },
                                child: Text('Clear',
                                    style: boldTextStyle(color: Colors.red)),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      color: appStore.isDarkModeOn
                                          ? bmTextColorDarkMode
                                          : bmPrimaryColor,
                                      icon: const Icon(Icons.photo),
                                      onPressed: () {
                                        pickImage(source: ImageSource.gallery);
                                      },
                                    ),
                                    IconButton(
                                      color: appStore.isDarkModeOn
                                          ? bmTextColorDarkMode
                                          : bmPrimaryColor,
                                      icon: const Icon(Icons.camera_alt),
                                      onPressed: () {
                                        pickImage(source: ImageSource.camera);
                                      },
                                    ),
                                  ]),
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
                        keyboardType: TextInputType.multiline,
                        focus: description,
                        initialValue: widget.category?.description ?? '',
                        nextFocus: null,
                        textFieldType: TextFieldType.MULTILINE,
                        onChanged: (value) {
                          widget.category!.description = value;
                          print(widget.category!.description);
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
                            }

                            var categoryData = widget.category?.toJson()
                              ?..removeWhere((key, value) =>
                                  value == null ||
                                  value == '' ||
                                  value == 'null' ||
                                  value == []);

                            Map<String, String> data = categoryData!
                                .map((k, v) => MapEntry(k, v.toString()));

                            Map<String, dynamic> files = {
                              'tagPic': widget.category?.tagPic,
                            };
                            data.remove('tagPic');

                            if (kDebugMode) {
                              print('data: $data');
                              print('files: $files');
                            }
                            categoryViewModel.sendCategoryData(
                                widget.tagId != null,
                                data,
                                isFileSelected,
                                files,
                                context);
                          }
                        },
                        child: categoryViewModel.loading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(widget.tagId == null ? 'Submit' : 'Update',
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
