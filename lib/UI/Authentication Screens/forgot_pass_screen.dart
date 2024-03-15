import 'package:chatapp/UI/Authentication%20Screens/widgets/button_widget.dart';
import 'package:chatapp/UI/Authentication%20Screens/widgets/foreground_widget.dart';
import 'package:chatapp/UI/Authentication%20Screens/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final TextEditingController _emailContoller = TextEditingController();

  ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: CircleAvatar(
                  backgroundColor: Colors.black26,
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ))),
        ),
        body: ForegroundWidget(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Forgot Password',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  const Text(
                      'Enter the email address associated with your account, and we’ll email you a link to reset your password.'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  const TextFieldHeader(
                    text: 'Email',
                    textColor: Colors.black,
                    letterSpacing: 2,
                  ),
                  CustomTextField(
                      key: key,
                      hintText: 'Enter your email',
                      obscureText: false,
                      controller: _emailContoller),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.10,
                  ),
                  CustomButton(
                    text: 'Send Resend Link',
                    height: 50,
                    backgroundColor: Colors.black,
                    borderColor: Colors.black,
                    textColor: Colors.white,
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
