import 'dart:convert';

import 'package:expertis/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../main.dart';
import '../utils/BMColors.dart';
import '../utils/BMWidgets.dart';
import 'package:provider/provider.dart';

class BMVerifyOTPScreen extends StatefulWidget {
  final String? email;
  final String? hash;

  BMVerifyOTPScreen({Key? key, this.email, this.hash}) : super(key: key);
  static const String routeName = '/verify-otp';

  @override
  State<BMVerifyOTPScreen> createState() => _BMVerifyOTPScreenState();
}

class _BMVerifyOTPScreenState extends State<BMVerifyOTPScreen> {
  String? otp = '';
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
            screenContext: context,
            child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                        Navigator.pop(context);
                      },
                    ),
                  ).withHeight(40),
                  headerText(title: 'Verify Email')
                ]),
          ),
          lowerContainer(
              screenContext: context,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    16.height,
                    Text(
                        'Please enter your email below to receive your password reset instructions.',
                        style: primaryTextStyle(
                            color: appStore.isDarkModeOn
                                ? Colors.white
                                : bmSpecialColorDark,
                            size: 14)),
                    20.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _textFieldOTP(first: true, last: false),
                        _textFieldOTP(first: false, last: false),
                        _textFieldOTP(first: false, last: false),
                        _textFieldOTP(first: false, last: false),
                        _textFieldOTP(first: false, last: false),
                        _textFieldOTP(first: false, last: true),
                      ],
                    ),
                    30.height,
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
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: bmPrimaryColor, borderRadius: radius(100)),
                          child: Container(
                            child: authViewModel.loading
                                ? const CircularProgressIndicator()
                                : IconButton(
                                    icon: const Icon(Icons.arrow_forward,
                                        color: Colors.white),
                                    onPressed: () {},
                                  ),
                          ),
                        ),
                      ],
                    )
                  ],
                ).paddingSymmetric(horizontal: 16),
              )).expand()
        ],
      ),
    );
  }

  Widget _textFieldOTP({bool first = true, last}) {
    return Container(
      height: 85,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextFormField(
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.purple),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
