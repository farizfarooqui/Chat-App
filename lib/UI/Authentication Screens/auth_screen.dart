import 'package:chatapp/UI/Authentication%20Screens/login_screen.dart';
import 'package:chatapp/UI/Authentication%20Screens/sign_up_screen.dart';
import 'package:chatapp/UI/Authentication%20Screens/widgets/button_widget.dart';
import 'package:chatapp/UI/Authentication%20Screens/widgets/foreground_widget.dart';
import 'package:flutter/material.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ForegroundWidget(
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                const Text(
                  'We Chat',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Container(
                    alignment: Alignment.bottomCenter,
                    child: CustomButton(
                        text: 'Login',
                        height: 50,
                        backgroundColor: Colors.white,
                        borderColor: Colors.white,
                        textColor: Colors.black,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const LoginScreen()));
                        })),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Container(
                    alignment: Alignment.bottomCenter,
                    child: CustomButton(
                        text: 'Sign Up',
                        height: 50,
                        backgroundColor: Colors.transparent,
                        borderColor: Colors.white,
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => SignUpScreen()));
                        })),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
