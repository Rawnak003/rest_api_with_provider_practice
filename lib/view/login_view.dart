import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rest_api_with_provider_practice/utils/routes/routes_name.dart';
import 'package:rest_api_with_provider_practice/utils/utils.dart';
import 'package:provider/provider.dart';
import '../res/components/round_button.dart';
import '../view_model/auth_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    _obscurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text(
          "Login",
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                focusNode: emailFocusNode,
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.black),
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      width: 3,
                      color: Colors.deepPurple.shade800,
                    ),
                  ),
                ),
                onFieldSubmitted: (value) {
                  Utils.changeFocusNode(
                    context,
                    emailFocusNode,
                    passwordFocusNode,
                  );
                },
              ),
              SizedBox(height: 10),
              ValueListenableBuilder(
                valueListenable: _obscurePassword,
                builder: (context, value, child) {
                  return TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword.value,
                    obscuringCharacter: '*',
                    focusNode: passwordFocusNode,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.black),
                      prefixIcon: Icon(Icons.lock_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          width: 3,
                          color: Colors.deepPurple.shade800,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                            _obscurePassword.value ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                        onPressed: () {
                          _obscurePassword.value = !_obscurePassword.value;
                        },
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 10),
              CustomRoundButton(width: width, height: height,
                title: 'Login',
                loading: authViewModel.loading,
                onTap: () {
                if(_emailController.text.isEmpty) {
                  Utils.flushBarErrorMessage("Please enter email", context);
                }else if(_passwordController.text.isEmpty) {
                  Utils.flushBarErrorMessage("Please enter password", context);
                }else if(_passwordController.text.length < 6) {
                  Utils.snackBar("Please enter 6 digit password", context);
                }else {
                  Map data = {
                    "email": _emailController.text.toString(),
                    "password": _passwordController.text.toString(),
                  };
                  authViewModel.loginApi(data, context);
                }
              },),
              SizedBox(height: 10),
              RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    children: [
                      TextSpan(
                        text: "Register",
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {
                            Navigator.pushNamed(context, RoutesName.signup);
                        },
                      ),
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}


