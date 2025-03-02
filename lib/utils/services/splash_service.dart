import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:rest_api_with_provider_practice/model/user_model.dart';
import 'package:rest_api_with_provider_practice/utils/routes/routes_name.dart';
import 'package:rest_api_with_provider_practice/view_model/user_view_model.dart';

class SplashService{
  Future<UserModel> getUserData() => UserViewModel().getUser();

  void checkAuthentication(context) async {
    getUserData().then((value) async {
      if(value.token.toString() == "null" || value.token.toString() == ''){
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushReplacementNamed(context, RoutesName.login);
      }else{
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushReplacementNamed(context, RoutesName.home);
      }
    }).onError((error, stackTrace){
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}