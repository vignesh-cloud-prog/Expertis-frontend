import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:expertis/utils/utils.dart';
import 'package:expertis/widgets/text_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:expertis/components/BMProfilePicComponent.dart';
import 'package:expertis/models/user_model.dart';
import 'package:expertis/view_model/auth_view_model.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../utils/BMColors.dart';
import '../utils/BMWidgets.dart';
import 'package:dotted_border/dotted_border.dart';

class BMCreateShopScreen extends StatefulWidget {
  final String title;
  final String buttonName;

  const BMCreateShopScreen(
      {Key? key, this.title = "Create Shop", this.buttonName = "Create"})
      : super(key: key);

  @override
  _BMCreateShopScreenState createState() => _BMCreateShopScreenState();
}

class _BMCreateShopScreenState extends State<BMCreateShopScreen> {
  FocusNode name = FocusNode();
  FocusNode role = FocusNode();
  FocusNode phone = FocusNode();
  FocusNode address = FocusNode();
  FocusNode pinCode = FocusNode();
  FocusNode dob = FocusNode();
  List<String> roles = ['MALE', 'FEMALE', 'UNISEX'];
  UserModel? user;
  String selectedRole = 'UNISEX';
  String userPic = "";
  File? image;
  String? selectedGender;
  bool isFileSelected = false;
  File? _pickedImage;
  Uint8List webImage = Uint8List(8);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _dobController = TextEditingController();

  Future pickImage(ImageSource source) async {
    try {
      var image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        return;
      }
      final directory = await getApplicationDocumentsDirectory();
      final name = basename(image.path);
      final imageFile = File('${directory.path}/$name');
      final newImage = await File(image.path).copy(imageFile.path);
      setState(() => user!.userPic = newImage.path);

      setState(() {
        isFileSelected = true;
        this.image = imageFile;
      });
    } on PlatformException catch (e) {
      // print("falied to pick image ${e.toString()}");
    }
  }

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

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);

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
                      ProfileWidget(
                        imagePath: '',
                        isEdit: true,
                        onClicked: () async {
                          await pickImage(ImageSource.gallery);
                        },
                      ),
                      20.height,
                      Text('Shop Name',
                          style: primaryTextStyle(
                              color: appStore.isDarkModeOn
                                  ? bmTextColorDarkMode
                                  : bmSpecialColor,
                              size: 14)),
                      AppTextField(
                        keyboardType: TextInputType.text,
                        nextFocus: role,
                        // onChanged: (value) {
                        //   user!.name = value;
                        // },
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
                      // Image to be picked code is here
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: _pickedImage == null
                                  ? dottedBorder(color: Colors.grey)
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: kIsWeb
                                          ? Image.memory(webImage,
                                              fit: BoxFit.fill)
                                          : Image.file(_pickedImage!,
                                              fit: BoxFit.fill),
                                    )),
                        ),
                      ),
                      Expanded(
                        child: FittedBox(
                          child: Column(
                            children: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _pickedImage = null;
                                    webImage = Uint8List(8);
                                  });
                                },
                                child: TextWidget(
                                  text: 'Clear',
                                  color: Colors.red,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: TextWidget(
                                  text: 'Update image',
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      20.height,

                      Text('Shop Id',
                          style: primaryTextStyle(
                              color: appStore.isDarkModeOn
                                  ? bmTextColorDarkMode
                                  : bmSpecialColor,
                              size: 14)),
                      AppTextField(
                        keyboardType: TextInputType.text,
                        nextFocus: role,
                        // onChanged: (value) {
                        //   user!.name = value;
                        // },
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
                        focusNode: role,
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
                          // user!.role = value.toString();
                        },
                        onSaved: ((newValue) {
                          Utils.focusChange(context, role, phone);
                        }),
                      ),
                      20.height,
                      Text('Enter your email',
                          style: primaryTextStyle(
                              color: appStore.isDarkModeOn
                                  ? bmTextColorDarkMode
                                  : bmSpecialColor,
                              size: 14)),
                      AppTextField(
                        keyboardType: TextInputType.emailAddress,
                        nextFocus: name,
                        textFieldType: TextFieldType.EMAIL,
                        // controller: _emailController,
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
                        // initialValue: user!.phone.toString(),
                        textFieldType: TextFieldType.PHONE,
                        // onChanged: (p0) => user!.phone = p0,
                        nextFocus: address,
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
                      20.height,
                      Text('Address',
                          style: primaryTextStyle(
                              color: appStore.isDarkModeOn
                                  ? bmTextColorDarkMode
                                  : bmSpecialColor,
                              size: 14)),
                      AppTextField(
                        keyboardType: TextInputType.text,
                        focus: address,
                        // initialValue: user!.address,
                        nextFocus: pinCode,
                        textFieldType: TextFieldType.NAME,
                        // onChanged: (value) {
                        // user!.address = value;
                        // },
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
                        focus: pinCode,
                        textFieldType: TextFieldType.PHONE,
                        autoFocus: true,
                        nextFocus: dob,
                        // initialValue: user!.pinCode.toString(),
                        // onChanged: (p0) => user!.pinCode = p0,
                        // controller: _pinCodeController,
                        validator: (value) {
                          if (value!.length != 6) {
                            return 'Pin code must be 6 digits';
                          }
                          return null;
                        },
                        errorThisFieldRequired: 'Pin code is required',
                        maxLength: 6,
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
                          if (_formKey.currentState!.validate()) {}
                        },
                        child: userViewModel.loading
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

  Future<void> _pickImage() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          _pickedImage = selected;
        });
      } else {
        print('No image has been picked');
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          webImage = f;
          _pickedImage = File('a');
        });
      } else {
        print('No image has been picked');
      }
    } else {
      print('Something went wrong');
    }
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
                      _pickImage();
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
