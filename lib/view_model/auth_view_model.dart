import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_with_provider_practice/model/user_model.dart';
import 'package:rest_api_with_provider_practice/utils/utils.dart';
import 'package:rest_api_with_provider_practice/view_model/user_view_model.dart';
import '../repository/auth_repository.dart';
import '../utils/routes/routes_name.dart';
import 'dart:convert';

class AuthViewModel extends ChangeNotifier {
  final _myRepository = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;
  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

   // Import this for jsonDecode

  Future<void> loginApi(dynamic data, context) async {
    setLoading(true);
    _myRepository.loginApi(data).then((value) {
      setLoading(false);
      Map<String, dynamic> responseJson = jsonDecode(value);

      if (responseJson.containsKey('token')) {
        final userPreference = Provider.of<UserViewModel>(context, listen: false);
        userPreference.saveUser(
          UserModel(
            token: responseJson['token'],
          ),
        );

        Utils.toastMessage("Login Successfully");
        Navigator.pushReplacementNamed(context, RoutesName.home);
      } else {
        Utils.flushBarErrorMessage("Token not found in response", context);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }



  Future<void> signupApi(dynamic data, context) async{
    setSignUpLoading(true);
    _myRepository.signupApi(data).then((value){
      setSignUpLoading(false);
      Utils.toastMessage("Sign Up Successful");
      Navigator.pushReplacementNamed(context, RoutesName.home);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace){
      setSignUpLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }
}