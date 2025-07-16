import 'dart:convert';
import 'package:beamer/beamer.dart';
import 'package:expertis/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../../main.dart';
import '../../../../utils/BMColors.dart';
import '../../../../utils/BMWidgets.dart';
import 'package:provider/provider.dart';

class BMForgetPasswordScreen extends StatefulWidget {
  const BMForgetPasswordScreen({super.key});
  static const String routeName = '/forget-password';

  @override
  State<BMForgetPasswordScreen> createState() => _BMForgetPasswordScreenState();
}

class _BMForgetPasswordScreenState extends State<BMForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

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
          children: [
            upperContainer(
              screenContext: context,
              child: headerText(title: 'Forget Password'),
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
                      30.height,
                      Text('Email',
                          style: primaryTextStyle(
                              color: appStore.isDarkModeOn
                                  ? bmTextColorDarkMode
                                  : bmSpecialColor,
                              size: 14)),
                      AppTextField(
                        keyboardType: TextInputType.emailAddress,
                        textFieldType: TextFieldType.EMAIL,
                        autoFocus: true,
                        controller: _emailController,
                        errorInvalidEmail:
                            'Please enter a valid email address.',
                        errorThisFieldRequired:
                            'Please enter your email address.',
                        cursorColor: bmPrimaryColor,
                        textStyle: boldTextStyle(
                            color: appStore.isDarkModeOn
                                ? Colors.white
                                : bmSpecialColorDark),
                        suffix: const Icon(Icons.check, color: Colors.teal),
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: appStore.isDarkModeOn
                                      ? bmPrimaryColor
                                      : context.iconColor)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: appStore.isDarkModeOn
                                      ? bmPrimaryColor
                                      : context.iconColor)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: appStore.isDarkModeOn
                                      ? bmPrimaryColor
                                      : context.iconColor)),
                        ),
                      ),
                      300.height,
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
                          Container(
                            decoration: BoxDecoration(
                                color: bmPrimaryColor,
                                borderRadius: radius(100)),
                            child: Container(
                              child: authViewModel.forgetPasswordLoading
                                  ? const CircularProgressIndicator()
                                  : IconButton(
                                      icon: const Icon(Icons.arrow_forward,
                                          color: Colors.white),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          Map data = {
                                            'email': _emailController.text
                                                .toString(),
                                          };
                                          authViewModel.forgotPasswordApi(
                                              jsonEncode(data), context);
                                        }
                                      },
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
      ),
    );
  }
}
