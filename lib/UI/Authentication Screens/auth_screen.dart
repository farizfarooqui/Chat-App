
import 'package:chatapp/UI/Authentication%20Screens/login_screen.dart';
import 'package:chatapp/UI/Authentication%20Screens/sign_up_screen.dart';
import 'package:chatapp/UI/Authentication%20Screens/widgets/button_widget.dart';
import 'package:chatapp/UI/Authentication%20Screens/widgets/foreground_widget.dart';
import 'package:flutter/material.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ForegroundWidget(
      children: [
        Column(
          children: [
            const Spacer(),
            Container(
                alignment: Alignment.center,
                width: 170,
                child: const Column(
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    Text(
                      'Glad to see you',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ],
                )),
            const Spacer(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 80, right: 80, top: 10),
                    child: CustomButton(
                        text: 'Login',
                        height: 50,
                        backgroundColor: Colors.black,
                        borderColor: Colors.black,
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const LoginScreen()));
                        }),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 80, right: 80, top: 10),
                    child: CustomButton(
                        text: 'Sign up',
                        height: 50,
                        backgroundColor: Colors.white,
                        borderColor: Colors.black,
                        textColor: Colors.black,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => SignUpScreen()));
                        }),
                  ),
                ],
              ),
            ),
            const Spacer()
          ],
        ),
      ],
    );
  }
}
