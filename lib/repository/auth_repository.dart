import 'package:rest_api_with_provider_practice/data/network/base_api_service.dart';
import 'package:rest_api_with_provider_practice/res/app_url.dart';

import '../data/network/network_api_service.dart';

class AuthRepository {
  final BaseApiService _apiService = NetworkApiService();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response = await _apiService.getPostApiResponse(AppURL.loginURL, data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> signupApi(dynamic data) async {
    try {
      dynamic response = await _apiService.getPostApiResponse(AppURL.signupURL, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}