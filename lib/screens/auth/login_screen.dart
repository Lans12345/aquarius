import 'package:aquarius/screens/auth/signup_screen.dart';
import 'package:aquarius/utils/colors.dart';
import 'package:aquarius/widget/button_widget.dart';
import 'package:aquarius/widget/textField_widget.dart';
import 'package:aquarius/widget/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();

  final passwordController = TextEditingController();

  String verID = " ";

  Future<void> verifyPhone(String number) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: number,
      timeout: const Duration(seconds: 20),
      verificationCompleted: (PhoneAuthCredential credential) {
        // Fluttertoast.showToast(msg: 'Completed');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: TextRegular(
                text: 'OTP Completed', fontSize: 14, color: Colors.white),
          ),
        );
      },
      verificationFailed: (FirebaseAuthException e) {
        // Fluttertoast.showToast(msg: 'Failed');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                TextRegular(text: 'Failed', fontSize: 14, color: Colors.white),
          ),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: TextRegular(
                text: 'OTP Sent', fontSize: 14, color: Colors.white),
          ),
        );
        verID = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Fluttertoast.showToast(msg: 'Timeout');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                TextRegular(text: 'Timeout', fontSize: 14, color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 800,
          width: 500,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.cover)),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 150,
                ),
                Image.asset(
                  'assets/images/aquarius.png',
                  width: 280,
                ),
                const SizedBox(
                  height: 120,
                ),
                TextFieldWidget(
                    inputType: TextInputType.number,
                    label: 'Phone Number',
                    controller: phoneController),
                TextFieldWidget(
                    isObscure: true,
                    label: 'Password',
                    controller: passwordController),
                const SizedBox(
                  height: 20,
                ),
                ButtonWidget(
                    label: 'Log In',
                    onPressed: (() async {
                      verifyPhone(phoneController.text);
                    }),
                    buttonColor: primary),
                const Expanded(
                  child: SizedBox(
                    height: 20,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextRegular(
                        fw: FontWeight.w700,
                        text: "Don't have an account?",
                        fontSize: 14,
                        color: Colors.white),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButton(
                        onPressed: (() {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => SignupScreen()));
                        }),
                        child: TextBold(
                            text: "Sign Up",
                            fontSize: 18,
                            color: Colors.white)),
                  ],
                ),
                const SizedBox(
                  height: 125,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
