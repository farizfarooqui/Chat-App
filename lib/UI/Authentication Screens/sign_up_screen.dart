import 'package:chatapp/Service/Auth%20Service/auth_service.dart';
import 'package:chatapp/UI/Authentication%20Screens/login_screen.dart';
import 'package:chatapp/UI/Authentication%20Screens/widgets/button_widget.dart';
import 'package:chatapp/UI/Authentication%20Screens/widgets/foreground_widget.dart';
import 'package:chatapp/UI/Authentication%20Screens/widgets/text_field_widget.dart';
import 'package:chatapp/UI/Home%20Screen/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool _isLoading = false;

  signUp(context) async {
    final authService = AuthService();

    setState(() {
      _isLoading = true;
    });
    if (_passwordController.text.trim() != _confirmController.text.trim()) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    try {
      await authService.registerWithEmailAndPasword(
        _emailController.text.trim(),
        _passwordController.text.trim(),
        _fullNameController.text.trim(),
        _confirmController.text.trim(),
      );
      DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
          .instance
          .collection('Users')
          .doc(_emailController.text)
          .get();
      String userName = userData['fullName'];
      String userEmail = userData['email'];

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => HomeScreen(
                    userName: userName,
                    userEmail: userEmail,
                  )));
      setState(() {
        _isLoading = false;
      });
    } on Exception catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
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
    return LoadingOverlay(
      isLoading: _isLoading,
      progressIndicator: SpinKitRing(
        color: Colors.purple.shade100,
        size: 50,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                physics:
                    const NeverScrollableScrollPhysics(), // Initially prevent scrolling
                child: Padding(
                  padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const Text(
                      'Create Account',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 30,
                          color: Colors.white),
                    ),
                    const Text(
                      'to get Started now!',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    CustomTextField(
                      hintText: 'Full name',
                      controller: _fullNameController,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    CustomTextField(
                      hintText: 'Email',
                      controller: _emailController,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    CustomTextField(
                      hintText: 'Password',
                      controller: _passwordController,
                      obscureText: true,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    CustomTextField(
                      hintText: 'Confirm Password',
                      obscureText: true,
                      controller: _confirmController,
                      showSuffixIcon: false,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    //login button
                    CustomButton(
                        text: 'Sign Up',
                        height: MediaQuery.of(context).size.height * 0.05,
                        backgroundColor: Colors.white,
                        borderColor: Colors.transparent,
                        textColor: Colors.black,
                        onPressed: () {
                          signUp(context);
                        }),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                    ),
                    //dont have an account
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account?',
                            style:
                                TextStyle(fontSize: 15, color: Colors.purple),
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const LoginScreen()));
                              },
                              child: const Text(
                                ' Login Now',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              )),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
