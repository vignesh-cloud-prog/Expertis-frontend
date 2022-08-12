import 'dart:convert';
import 'package:beamer/beamer.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:expertis/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../utils/BMColors.dart';
import '../utils/BMWidgets.dart';
import 'package:provider/provider.dart';

class BMVerifyOTPScreen extends StatefulWidget {
  const BMVerifyOTPScreen({Key? key}) : super(key: key);
  static const String routeName = '/verify-otp';

  @override
  State<BMVerifyOTPScreen> createState() => _BMVerifyOTPScreenState();
}

class _BMVerifyOTPScreenState extends State<BMVerifyOTPScreen> {
  final TextEditingController _otpController = TextEditingController();
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
      body: Column(
        children: [
          upperContainer(
              screenContext: context, child: headerText(title: 'Verify Email')),
          lowerContainer(
              screenContext: context,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    26.height,
                    Text('OTP is sent to your email ${authViewModel.email}',
                        style: primaryTextStyle(
                            color: appStore.isDarkModeOn
                                ? Colors.white
                                : bmSpecialColorDark,
                            size: 14)),
                    10.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Enter your OTP',
                            style: primaryTextStyle(
                                color: appStore.isDarkModeOn
                                    ? bmTextColorDarkMode
                                    : bmSpecialColor,
                                size: 14)),
                        TextButton(
                          onPressed: () {
                            // BMForgetPasswordScreen().launch(context);
                          },
                          child: authViewModel.forgetPasswordLoading
                              ? Row(
                                  children: [
                                    Text('Sending OTP',
                                        style: primaryTextStyle(
                                            color: appStore.isDarkModeOn
                                                ? bmTextColorDarkMode
                                                : bmSpecialColor,
                                            size: 14)),
                                    SizedBox(width: 8),
                                    CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          appStore.isDarkModeOn
                                              ? bmTextColorDarkMode
                                              : bmSpecialColor),
                                    ),
                                  ],
                                )
                              : InkWell(
                                  onTap: () {
                                    Map data = {'email': authViewModel.email};
                                    authViewModel.forgotPasswordApi(
                                        jsonEncode(data), context);
                                  },
                                  child: Text('Resend OTP',
                                      style: boldTextStyle(
                                          color: appStore.isDarkModeOn
                                              ? bmPrimaryColor
                                              : bmGreyColor,
                                          size: 14)),
                                ),
                        )
                      ],
                    ),
                    5.height,
                    PinCodeTextField(
                      appContext: context,
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor: bmPrimaryColor,
                          selectedFillColor: Colors.yellow[100],
                          inactiveColor: bmGreyColor,
                          selectedColor: Colors.amber,
                          activeColor: bmSpecialColor,
                          inactiveFillColor: Colors.white),
                      animationDuration: Duration(milliseconds: 300),
                      autoFocus: true,
                      // backgroundColor: Colors.blue.shade50,
                      enableActiveFill: true,
                      // errorAnimationController: errorController,
                      controller: _otpController,

                      onCompleted: (v) {},
                      onChanged: (value) {
                        // print(value);
                      },
                      beforeTextPaste: (text) {
                        // print("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    ),
                    60.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: appStore.isDarkModeOn
                                  ? bmTextColorDarkMode.withOpacity(0.5)
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
                        AppButton(
                          // enabled:(_otpController.text.length == 6) ? true : false,
                          disabledColor: bmPrimaryColor,
                          shapeBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32)),
                          padding: const EdgeInsets.all(16),
                          color: bmPrimaryColor,
                          onTap: () {
                            // print("otp: ${_otpController.text}");
                            // print("length: ${_otpController.text.length}");
                            if (!_otpController.text.isEmptyOrNull &&
                                _otpController.text.length == 6) {
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.

                              Map data = {
                                'id': authViewModel.id,
                                'otp': _otpController.text.toString(),
                                'hash': authViewModel.hash,
                              };
                              authViewModel.verifyOTP(
                                  json.encode(data), context);
                            }
                          },
                          child: authViewModel.loading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text("Verify",
                                  style: boldTextStyle(color: Colors.white)),
                        )
                      ],
                    )
                  ],
                ).paddingSymmetric(horizontal: 16),
              )).expand()
        ],
      ),
    );
  }
}
