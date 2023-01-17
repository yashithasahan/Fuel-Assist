import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:provider/provider.dart';
import 'package:speed_shop/common/widgets/custom_button.dart';
import 'package:speed_shop/common/widgets/custom_rolling_button.dart';
import 'package:speed_shop/common/widgets/custom_textfield.dart';
import 'package:speed_shop/constant/global_var.dart';
import 'package:speed_shop/features/auth/services/auth_service.dart';

import '../../../providers/user_provider.dart';

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormkey = GlobalKey<FormState>();
  final _signinFormkey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool? _isOwner = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
      type: _isOwner.toString(),
    );
  }

  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: DefaultTextStyle(
          style: const TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.w600),
          child: AnimatedTextKit(
            animatedTexts: [
              WavyAnimatedText('Wellcome !'),
              WavyAnimatedText('Fuel Assits'),
            ],
            isRepeatingAnimation: true,
            totalRepeatCount: 2,
          ),
        )),
        elevation: 6,
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: GlobalVar.appBarGradient),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                const SizedBox(
                  height: 10,
                ),

                ListTile(
                  title: const Text(
                    'Create Account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Radio(
                    activeColor: GlobalVar.secondaryColor,
                    value: Auth.signup,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Sign In',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Radio(
                    activeColor: GlobalVar.secondaryColor,
                    value: Auth.signin,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    },
                  ),
                ),
                if (_auth == Auth.signup)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: GlobalVar.backgroundColor,
                    child: Form(
                      key: _signUpFormkey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: _nameController,
                            hintText: 'Name',
                            userIcon: const Icon(Icons.person_outline),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            controller: _emailController,
                            hintText: 'Email',
                            userIcon: const Icon(Icons.email_outlined),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            controller: _passwordController,
                            hintText: 'Password',
                            password: true,
                            userIcon: const Icon(Icons.lock_outline),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CheckboxListTile(
                            value: _isOwner,
                            onChanged: (bool? value) {
                              setState(() {
                                _isOwner = value;
                              });
                            },
                            title: const Text("I have/work on a fuel station"),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                              text: 'Sign up',
                              onTap: () {
                                if (_signUpFormkey.currentState!.validate()) {
                                  signUpUser();
                                }
                              })
                        ],
                      ),
                    ),
                  ),
                
                // Sign IN
                if (_auth == Auth.signin)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: GlobalVar.backgroundColor,
                    child: Form(
                      key: _signinFormkey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: _emailController,
                            hintText: 'Email',
                            userIcon: const Icon(Icons.email_outlined),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            controller: _passwordController,
                            hintText: 'Password',
                            password: true,
                            userIcon: const Icon(Icons.lock_outline),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                              text: 'Sign In',
                              onTap: () {
                                if (_signinFormkey.currentState!.validate()) {
                                  signInUser();
                                }
                              })
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
