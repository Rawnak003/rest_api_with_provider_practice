import 'package:flutter/material.dart';
import 'package:rest_api_with_provider_practice/utils/routes/routes_name.dart';
import 'package:rest_api_with_provider_practice/view/login_view.dart';
import '../../view/home_screen.dart';
import '../../view/signup_view.dart';
import '../../view/splash_view.dart';

class Routes{
  static MaterialPageRoute generateRoute(RouteSettings settings){
    switch(settings.name){
      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context) => const LoginView());
      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context) => const HomeScreen());
      case RoutesName.signup:
        return MaterialPageRoute(builder: (BuildContext context) => const SignUpView());
      case RoutesName.splash:
        return MaterialPageRoute(builder: (BuildContext context) => const SplashView());
      default:
        return MaterialPageRoute(builder: (context) => const LoginView());
    }
  }
}