import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../components/BMSocialIconsLoginComponents.dart';
import '../main.dart';
import '../utils/BMColors.dart';
import '../utils/BMWidgets.dart';
import 'BMDashboardScreen.dart';
import 'BMForgetPasswordScreen.dart';
import 'BMRegisterScreen.dart';
import 'package:expertis/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class BMLoginScreen extends StatefulWidget {
  const BMLoginScreen({Key? key}) : super(key: key);
  static const String routeName = '/login';

  @override
  State<BMLoginScreen> createState() => _BMLoginScreenState();
}

class _BMLoginScreenState extends State<BMLoginScreen> {
  FocusNode password = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    setStatusBarColor(bmSpecialColor);
    super.initState();
  }

  @override
  void dispose() {
    setStatusBarColor(Colors.transparent);
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewMode = Provider.of<AuthViewModel>(context);

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
              child: headerText(title: 'Login'),
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
                        Text('Not a member yet?',
                            style: boldTextStyle(
                                color: appStore.isDarkModeOn
                                    ? bmTextColorDarkMode
                                    : bmSpecialColorDark)),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, BMRegisterScreen.routeName);
                            // BMRegisterScreen().launch(context);
                          },
                          child: Text(
                            'Register Now',
                            style: boldTextStyle(
                                color: appStore.isDarkModeOn
                                    ? bmPrimaryColor
                                    : bmGreyColor),
                          ),
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
                      nextFocus: password,
                      controller: _emailController,
                      textFieldType: TextFieldType.EMAIL,
                      isValidationRequired: true,
                      errorThisFieldRequired: 'Email is required',
                      errorInvalidEmail: 'Invalid email',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Password',
                            style: primaryTextStyle(
                                color: appStore.isDarkModeOn
                                    ? bmTextColorDarkMode
                                    : bmSpecialColor,
                                size: 14)),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, BMForgetPasswordScreen.routeName);
                            // BMForgetPasswordScreen().launch(context);
                          },
                          child: Text('Forgot Password',
                              style: boldTextStyle(
                                  color: appStore.isDarkModeOn
                                      ? bmPrimaryColor
                                      : bmGreyColor,
                                  size: 14)),
                        )
                      ],
                    ),
                    AppTextField(
                      focus: password,
                      controller: _passwordController,
                      textFieldType: TextFieldType.PASSWORD,
                      errorThisFieldRequired: 'Password is required',
                      autoFocus: true,
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
                    Row(
                      children: [
                        AppButton(
                          enabled: !authViewMode.loading,
                          disabledColor: bmPrimaryColor,
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
                              };
                              authViewMode.loginApi(json.encode(data), context);
                            }

                            // Navigator.pushNamed(context, BMLoginScreen.routeName);
                            // BMDashboardScreen(flag: false).launch(context);
                          },
                          child: authViewMode.loading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text("Login",
                                  style: boldTextStyle(color: Colors.white)),
                        ).expand(),

                        // 16.width,
                        // AppButton(
                        //   height: 40,
                        //   width: 40,
                        //   child:
                        //       Icon(Icons.qr_code_scanner_rounded, color: white),
                        //   shapeBorder: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(100)),
                        //   padding: EdgeInsets.all(16),
                        //   color: Colors.grey,
                        //   onTap: () {
                        //     //
                        //   },
                        // ),
                      ],
                    ),
                    // 30.height,
                    // Text(
                    //   'or login with',
                    //   style: secondaryTextStyle(
                    //       color: appStore.isDarkModeOn
                    //           ? bmTextColorDarkMode
                    //           : bmSpecialColorDark),
                    // ).center(),
                    // 30.height,
                    // BMSocialIconsLoginComponents().center(),
                  ],
                ).paddingSymmetric(horizontal: 16),
              ),
            ).expand()
          ],
        ),
      ),
    );
  }
}
