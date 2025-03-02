import 'dart:convert';

import 'package:rest_api_with_provider_practice/data/network/base_api_service.dart';
import 'package:rest_api_with_provider_practice/data/network/network_api_service.dart';
import 'package:rest_api_with_provider_practice/model/movie_list_model.dart';

import '../res/app_url.dart';

class HomeRepository{

  final BaseApiService _apiService = NetworkApiService();

  Future<MovieListModel> fetchMoviesListApi() async {
    try {
      dynamic response = await _apiService.getGetApiResponse(AppURL.movieListURL);
      Map<String, dynamic> decodedResponse = jsonDecode(response);
      response = MovieListModel.fromJson(decodedResponse);

      return response;
    } catch (e) {
      throw e;
    }
  }
}