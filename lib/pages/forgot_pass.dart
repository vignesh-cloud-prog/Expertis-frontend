import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../assets/constants.dart';

import '../services/api_service.dart';
import 'otp_verify_page.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool enableBtn = false;
  bool isAPIcallProcess = false;
  final emailTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(45),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: FadeInLeft(
              delay: Duration(milliseconds: 2100),
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
              right: 12,
              left: 15,
              bottom: 15,
            ),
            width: gWidth,
            height: gHeight,
            child: Column(
              children: [
                TopImage(),
                SizedBox(
                  height: 5,
                ),
                ForgotText(),
                SizedBox(
                  height: 20,
                ),
                MiddleText(),
                SizedBox(height: 30),
                FadeInDown(
                    delay: Duration(milliseconds: 600),
                    child: TextFormField(
                      controller: emailTextEditingController,
                    )),
                SizedBox(height: 50),
                FadeInDown(
                  delay: Duration(microseconds: 200),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: gWidth,
                    height: gHeight / 15,
                    child: ElevatedButton(
                      onPressed: () {
                        print("presse");
                        print("email ${emailTextEditingController.text}");
                        APIService.otpLogin(emailTextEditingController.text)
                            .then((response) async {
                          setState(() {
                            this.isAPIcallProcess = false;
                          });

                          if (response.data != null) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OTPVerifyPage(
                                  otpHash: response.data,
                                  email: emailTextEditingController.text,
                                ),
                              ),
                              (route) => false,
                            );
                          }
                        });
                      },
                      child: Text("Submit"),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(buttonColor),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Submit Button Components
// class SubmitButton extends StatelessWidget {
//   const SubmitButton({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FadeInDown(
//       delay: Duration(microseconds: 200),
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 5),
//         width: gWidth,
//         height: gHeight / 15,
//         child: ElevatedButton(
//           onPressed: () {
//             print("presse");
//             APIService.otpLogin(this.email).then((response) async {
//                     setState(() {
//                       this.isAPIcallProcess = false;
//                     });

//                     if (response.data != null) {
//                       Navigator.pushAndRemoveUntil(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => OTPVerifyPage(
//                             otpHash: response.data,
//                             mobileNo: mobileNumber,
//                           ),
//                         ),
//                         (route) => false,
//                       );
//                     }
//                   });
//           },
//           child: Text("Submit"),
//           style: ButtonStyle(
//             shape: MaterialStateProperty.all(
//               RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//             ),
//             backgroundColor: MaterialStateProperty.all(buttonColor),
//           ),
//         ),
//       ),
//     );
//   }
// }

// String validateEmail(String value) {
//     Pattern pattern =
//         r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
//         r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
//         r"{0,253}[a-zA-Z0-9])?)*$";
//     RegExp regex = new RegExp(pattern);
//     if (!regex.hasMatch(value) || value == null)
//       return 'Enter a valid email address';
//     else
//       return null;
//   }

// Email TextFiled Components
// class EmailTextFiled extends StatefulWidget {
//   final dynamic email;
//   const EmailTextFiled({
//     Key? key,
//     this.email
//   }) : super({key: key});

//   @override
//   State<EmailTextFiled> createState() => _EmailTextFiledState();
// }

// class _EmailTextFiledState extends State<ForgotPasswordScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return FadeInDown(
//       delay: Duration(milliseconds: 600),
//       child: TextFormField(
//         onSaved: (newValue) => widget.email = newValue,

// );
//     );
//   }
// }

// Middle Text Components
class MiddleText extends StatelessWidget {
  const MiddleText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: Duration(milliseconds: 1000),
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          width: gWidth,
          height: gHeight / 19,
          child: Text(
            "Don\'t worry! it happens. Please enter the address associated with you\'r account.",
            style: TextStyle(color: text1Color, height: 1.2, wordSpacing: 2),
          )),
    );
  }
}

// Top Forgot Text Components
class ForgotText extends StatelessWidget {
  const ForgotText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      delay: Duration(milliseconds: 1400),
      child: Container(
        margin: EdgeInsets.only(right: 160, top: 10),
        width: gWidth / 2,
        height: gHeight / 8,
        child: FittedBox(
          child: Text(
            "Forgot\nPassword?",
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

// Top Image Components
class TopImage extends StatelessWidget {
  const TopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: Duration(milliseconds: 1800),
      child: Container(
        width: gWidth,
        height: gHeight / 2.7,
        child: Image.asset(
          "assets/images/forgot.png",
        ),
      ),
    );
  }
}
