import 'dart:convert';

import 'package:beamer/beamer.dart';
import 'package:expertis/screens/login_screen.dart';
import 'package:expertis/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../utils/BMColors.dart';
import '../utils/BMWidgets.dart';

class BMChangePasswordScreen extends StatefulWidget {
  const BMChangePasswordScreen({Key? key}) : super(key: key);
  static const String routeName = '/change-password';
  @override
  State<BMChangePasswordScreen> createState() => _BMChangePasswordScreenState();
}

class _BMChangePasswordScreenState extends State<BMChangePasswordScreen> {
  FocusNode newPassword = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  FocusNode confirmPassword = FocusNode();

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
          children: [
            upperContainer(
              screenContext: context,
              child: headerText(title: 'Change Password'),
            ),
            lowerContainer(
                screenContext: context,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      16.height,
                      Text(
                          'Reset code was sent to your email ${authViewModel.email}. Please enter the code and create a new password.',
                          style: primaryTextStyle(
                              color: appStore.isDarkModeOn
                                  ? Colors.white
                                  : bmSpecialColorDark,
                              size: 14)),
                      30.height,
                      Text('Reset Code',
                          style: primaryTextStyle(
                              color: appStore.isDarkModeOn
                                  ? bmTextColorDarkMode
                                  : bmSpecialColor,
                              size: 14)),
                      AppTextField(
                        nextFocus: newPassword,
                        maxLength: 6,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        textFieldType: TextFieldType.PHONE,
                        controller: _otpController,
                        autoFocus: true,
                        cursorColor: bmPrimaryColor,
                        textStyle: boldTextStyle(
                            color: appStore.isDarkModeOn
                                ? Colors.white
                                : bmSpecialColorDark),
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
                      16.height,
                      Text('New Password',
                          style: primaryTextStyle(
                              color: appStore.isDarkModeOn
                                  ? bmTextColorDarkMode
                                  : bmSpecialColor,
                              size: 14)),
                      AppTextField(
                        focus: newPassword,
                        nextFocus: confirmPassword,
                        controller: _passwordController,
                        textInputAction: TextInputAction.next,
                        textFieldType: TextFieldType.PASSWORD,
                        cursorColor: bmPrimaryColor,
                        suffixIconColor: appStore.isDarkModeOn
                            ? Colors.white
                            : bmPrimaryColor,
                        textStyle: boldTextStyle(
                            color: appStore.isDarkModeOn
                                ? Colors.white
                                : bmSpecialColorDark),
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
                      16.height,
                      Text('Confirm Password',
                          style: primaryTextStyle(
                              color: appStore.isDarkModeOn
                                  ? bmTextColorDarkMode
                                  : bmSpecialColor,
                              size: 14)),
                      AppTextField(
                        focus: confirmPassword,
                        textInputAction: TextInputAction.done,
                        textFieldType: TextFieldType.PASSWORD,
                        cursorColor: bmPrimaryColor,
                        controller: _confirmPasswordController,
                        textStyle: boldTextStyle(
                            color: appStore.isDarkModeOn
                                ? Colors.white
                                : bmSpecialColorDark),
                        suffix: Icon(Icons.check, color: Colors.teal),
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal)),
                        ),
                      ),
                      100.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: appStore.isDarkModeOn
                                    ? bmTextColorDarkMode.withAlpha(50)
                                    : bmPrimaryColor.withAlpha(70),
                                borderRadius: radius(100)),
                            child: IconButton(
                              icon: Icon(Icons.arrow_back,
                                  color: appStore.isDarkModeOn
                                      ? Colors.white
                                      : bmPrimaryColor),
                              onPressed: () {
                                Beamer.of(context).beamBack();
                              },
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.teal, borderRadius: radius(100)),
                            child: IconButton(
                              icon: Container(
                                  child: authViewModel.loading
                                      ? CircularProgressIndicator()
                                      : const Icon(Icons.check,
                                          color: Colors.white)),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Map data = {
                                    'email': authViewModel.email,
                                    'password':
                                        _passwordController.text.toString(),
                                    'hash': authViewModel.hash,
                                    'otp': _otpController.text.toString()
                                  };

                                  authViewModel.changePassword(
                                      jsonEncode(data), context);
                                }
                              },
                            ),
                          )
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
