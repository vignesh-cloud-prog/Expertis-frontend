import 'dart:io';
import 'package:expertis/utils/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:expertis/components/BMProfilePicComponent.dart';
import 'package:expertis/models/user_model.dart';
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
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';

class BMUserProfileEditScreen extends StatefulWidget {
  final String title;
  final String buttonName;

  const BMUserProfileEditScreen(
      {Key? key, this.title = "Update Profile", this.buttonName = "Update"})
      : super(key: key);

  @override
  BMUserProfileEditScreenState createState() => BMUserProfileEditScreenState();
}

class BMUserProfileEditScreenState extends State<BMUserProfileEditScreen> {
  FocusNode name = FocusNode();
  FocusNode role = FocusNode();
  FocusNode phone = FocusNode();
  FocusNode address = FocusNode();
  FocusNode pinCode = FocusNode();
  FocusNode dob = FocusNode();
  List<String> roles = ['CUSTOMER', 'OWNER', 'MEMBER'];
  UserModel? user;
  String selectedRole = 'CUSTOMER';
  String userPic = "";
  File? image;
  String? selectedGender;
  bool isFileSelected = false;

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
      if (kDebugMode) {
        print("failed to pick image ${e.toString()}");
      }
    }
  }

  @override
  void initState() {
    setStatusBarColor(bmSpecialColor);
    UserViewModel.getUser().then((value) {
      setState(() {
        user = value;
        _dobController.text = user!.dob.toString().splitBefore('T');
        selectedRole = user!.role ?? 'CUSTOMER';
      });
    });
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
                        imagePath: user!.userPic,
                        isEdit: true,
                        onClicked: () async {
                          await pickImage(ImageSource.gallery);
                        },
                      ),
                      20.height,
                      Text('Name',
                          style: primaryTextStyle(
                              color: appStore.isDarkModeOn
                                  ? bmTextColorDarkMode
                                  : bmSpecialColor,
                              size: 14)),
                      AppTextField(
                        keyboardType: TextInputType.text,
                        nextFocus: role,
                        initialValue: user!.name.toString(),
                        onChanged: (value) {
                          user!.name = value;
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
                      Text('Role',
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
                          user!.role = value.toString();
                        },
                        onSaved: ((newValue) {
                          Utils.focusChange(context, role, phone);
                        }),
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
                        initialValue: user!.phone.toString(),
                        textFieldType: TextFieldType.PHONE,
                        onChanged: (p0) => user!.phone = p0,
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
                      Text('City',
                          style: primaryTextStyle(
                              color: appStore.isDarkModeOn
                                  ? bmTextColorDarkMode
                                  : bmSpecialColor,
                              size: 14)),
                      AppTextField(
                        keyboardType: TextInputType.text,
                        focus: address,
                        initialValue:
                            user!.address == "null" ? "" : user!.address,
                        nextFocus: pinCode,
                        textFieldType: TextFieldType.NAME,
                        onChanged: (value) {
                          user!.address = value;
                        },
                        // controller: _addressController,
                        errorThisFieldRequired: 'City name is required',
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
                        initialValue: user!.pinCode.toString() == "null"
                            ? ""
                            : user!.pinCode.toString(),
                        onChanged: (p0) => user!.pinCode = p0,
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
                      20.height,
                      Text('Date of Birth',
                          style: primaryTextStyle(
                              color: appStore.isDarkModeOn
                                  ? bmTextColorDarkMode
                                  : bmSpecialColor,
                              size: 14)),
                      InkWell(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              var date =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              user!.dob = date;
                              _dobController.text = date;
                            });
                          }
                        },
                        child: AppTextField(
                          focus: dob,
                          readOnly: true,
                          textFieldType: TextFieldType.OTHER,
                          suffix: InkWell(
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  var date = DateFormat('yyyy-MM-dd')
                                      .format(pickedDate);
                                  user!.dob = date;
                                  _dobController.text = date;
                                });
                              }
                            },
                            child: const Icon(
                              Icons.calendar_today,
                              color: bmPrimaryColor,
                            ),
                          ),
                          nextFocus: null,
                          controller: _dobController,
                          errorThisFieldRequired: 'DOB is required',
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
                      ),
                      20.height,
                      Text('Gender',
                          style: primaryTextStyle(
                              color: appStore.isDarkModeOn
                                  ? bmTextColorDarkMode
                                  : bmSpecialColor,
                              size: 14)),
                      20.height,
                      GenderPickerWithImage(
                        showOtherGender: true,
                        verticalAlignedText: false,

                        selectedGender: user!.gender!.toLowerCase() == "male"
                            ? Gender.Male
                            : user!.gender!.toLowerCase() == "female"
                                ? Gender.Female
                                : Gender.Others,
                        selectedGenderTextStyle: TextStyle(
                            color: appStore.isDarkModeOn
                                ? bmTextColorDarkMode
                                : bmPrimaryColor,
                            fontWeight: FontWeight.bold),
                        unSelectedGenderTextStyle: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.normal),
                        onChanged: (Gender? gender) {
                          selectedGender =
                              gender.toString().splitAfter(".").toUpperCase();
                          user!.gender = selectedGender;
                          if (kDebugMode) {
                            // print("selectedGender $selectedGender");
                          }
                        },
                        equallyAligned: true,
                        animationDuration: const Duration(milliseconds: 300),
                        isCircular: true,
                        // default : true,
                        opacityOfGradient: 0.4,
                        padding: const EdgeInsets.all(3),
                        size: 50, //default : 40
                      ),
                      Divider(
                        color: appStore.isDarkModeOn
                            ? bmTextColorDarkMode
                            : bmPrimaryColor,
                        thickness: 1,
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
                            Map<String, String> data = user!
                                .toJson()
                                .map((k, v) => MapEntry(k, v.toString()));
                            Map<String, String> files = {
                              'userPic': user!.userPic.toString(),
                            };
                            data.remove('userPic');
                            userViewModel.updateUser(
                                true, data, isFileSelected, files, context);
                          }
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
}
