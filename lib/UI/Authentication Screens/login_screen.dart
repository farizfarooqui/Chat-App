import 'package:chatapp/Auth%20Service/auth_service.dart';
import 'package:chatapp/UI/Authentication%20Screens/forgot_pass_screen.dart';
import 'package:chatapp/UI/Authentication%20Screens/sign_up_screen.dart';
import 'package:chatapp/UI/Authentication%20Screens/widgets/button_widget.dart';
import 'package:chatapp/UI/Authentication%20Screens/widgets/foreground_widget.dart';
import 'package:chatapp/UI/Authentication%20Screens/widgets/text_field_widget.dart';
import 'package:chatapp/UI/Home%20Screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final TextEditingController emailContoller = TextEditingController();
final TextEditingController passwordContoller = TextEditingController();

class _LoginScreenState extends State<LoginScreen> {
  login(context) async {
    final authService = AuthService();
    try {
      await authService.signInWithEmailAndPassword(
          emailContoller.text.trim(), passwordContoller.text.trim());

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Error"),
              content: Text(e.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
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
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus
            ?.unfocus(), // Hide keyboard when tapping outside
        child: ForegroundWidget(
          children: [
            SingleChildScrollView(
              // physics:
              //     const NeverScrollableScrollPhysics(), // Initially prevent scrolling
              child: Padding(
                padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const Text(
                    'Welcome',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  const Text(
                    'Glad to see you',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  CustomTextField(
                    hintText: 'Email',
                    controller: emailContoller,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    hintText: 'Password',
                    obscureText: true,
                    controller: passwordContoller,
                    showSuffixIcon: true,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  //forget password
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ForgetPasswordScreen()));
                        },
                        child: const Text(
                          'Forget password?',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.end,
                        )),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  //login button
                  CustomButton(
                      text: 'Login',
                      height: MediaQuery.of(context).size.height * 0.06,
                      backgroundColor: Colors.white,
                      borderColor: Colors.transparent,
                      textColor: Colors.black,
                      onPressed: () {
                        login(context);
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  //divider
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.white,
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Or Login with',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.white,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Buttons
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                            text: 'Google',
                            height: 50,
                            backgroundColor: Colors.white,
                            borderColor: Colors.transparent,
                            textColor: Colors.black,
                            onPressed: () {}),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomButton(
                            text: 'Facebook',
                            height: 50,
                            backgroundColor: Colors.white,
                            borderColor: Colors.transparent,
                            textColor: Colors.black,
                            onPressed: () {}),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  //dont have an account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account?',
                        style: TextStyle(fontSize: 15, color: Colors.purple),
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SignUpScreen()));
                          },
                          child: const Text(
                            ' SignUp now',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          )),
                    ],
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
