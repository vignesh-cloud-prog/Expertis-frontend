import 'dart:convert';

import 'package:beamer/beamer.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../../../main.dart';
import '../../../../utils/BMColors.dart';
import '../../../../utils/BMWidgets.dart';

class BMRegisterScreen extends StatefulWidget {
  const BMRegisterScreen({Key? key}) : super(key: key);
  static const String routeName = '/register';

  @override
  _BMRegisterScreenState createState() => _BMRegisterScreenState();
}

class _BMRegisterScreenState extends State<BMRegisterScreen> {
  FocusNode name = FocusNode();
  FocusNode password = FocusNode();
  FocusNode phone = FocusNode();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

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
    final authViewModel = Provider.of<AuthViewModel>(context);

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
              child: headerText(title: 'Register'),
            ),
            lowerContainer(
                screenContext: context,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      16.height,
                      Row(
                        children: [
                          Text('Are you a member?',
                              style: boldTextStyle(
                                  color: appStore.isDarkModeOn
                                      ? Colors.white
                                      : bmSpecialColorDark)),
                          TextButton(
                            onPressed: () {
                              Beamer.of(context).beamToNamed(RoutesName.login);
                            },
                            child: Text('Login Now',
                                style: boldTextStyle(
                                    color: appStore.isDarkModeOn
                                        ? bmPrimaryColor
                                        : Colors.grey)),
                          )
                        ],
                      ),
                      30.height,
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
                        controller: _emailController,
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
                      Text('Enter your name',
                          style: primaryTextStyle(
                              color: appStore.isDarkModeOn
                                  ? bmTextColorDarkMode
                                  : bmSpecialColor,
                              size: 14)),
                      AppTextField(
                        keyboardType: TextInputType.text,
                        focus: name,
                        nextFocus: phone,
                        textFieldType: TextFieldType.NAME,
                        controller: _nameController,
                        errorThisFieldRequired: 'Name is required',
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
                        textFieldType: TextFieldType.PHONE,
                        autoFocus: true,
                        nextFocus: password,
                        controller: _phoneController,
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
                      Text('Create password',
                          style: primaryTextStyle(
                              color: appStore.isDarkModeOn
                                  ? bmTextColorDarkMode
                                  : bmSpecialColor,
                              size: 14)),
                      AppTextField(
                        focus: password,
                        textFieldType: TextFieldType.PASSWORD,
                        autoFocus: true,
                        nextFocus: null,
                        controller: _passwordController,
                        errorThisFieldRequired: 'Password is required',
                        errorMinimumPasswordLength:
                            'Password must be at least 6 characters',
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
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.

                            Map data = {
                              'email': _emailController.text.toString(),
                              'password': _passwordController.text.toString(),
                              'name': _nameController.text.toString(),
                              'phone': _phoneController.text.toString(),
                            };
                            authViewModel.signUp(jsonEncode(data), context);
                          }
                          // BMEnableLocationScreen().launch(context);
                        },
                        child: authViewModel.signUpLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text('Join Now',
                                style: boldTextStyle(color: Colors.white)),
                      ),
                      30.height,
                      // Text(
                      //   'or register with',
                      //   style: secondaryTextStyle(
                      //       color: appStore.isDarkModeOn
                      //           ? bmTextColorDarkMode
                      //           : bmSpecialColorDark),
                      // ).center(),
                      // 30.height,
                      // BMSocialIconsLoginComponents().center(),
                      // 30.height,
                      Text(
                        'By clicking Join Bablus, you agreeing to',
                        style: secondaryTextStyle(
                            color: appStore.isDarkModeOn
                                ? Colors.white
                                : bmSpecialColorDark,
                            size: 12),
                      ).center(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('the ',
                              style: secondaryTextStyle(
                                  color: appStore.isDarkModeOn
                                      ? Colors.white
                                      : bmSpecialColorDark,
                                  size: 12)),
                          Text('Terms of Use',
                              style: secondaryTextStyle(
                                  color: appStore.isDarkModeOn
                                      ? bmPrimaryColor
                                      : Colors.grey,
                                  decoration: TextDecoration.underline)),
                          Text(' and the ',
                              style: secondaryTextStyle(
                                  color: appStore.isDarkModeOn
                                      ? Colors.white
                                      : bmSpecialColorDark,
                                  size: 12)),
                          Text('Privacy Policy',
                              style: secondaryTextStyle(
                                  color: appStore.isDarkModeOn
                                      ? bmPrimaryColor
                                      : Colors.grey,
                                  decoration: TextDecoration.underline)),
                        ],
                      )
                    ],
                  ).paddingSymmetric(horizontal: 16),
                )).expand()
          ],
        ),
      ),
    );
  }
}
