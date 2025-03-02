import 'package:flutter/cupertino.dart';
import 'package:rest_api_with_provider_practice/data/response/api_response.dart';
import 'package:rest_api_with_provider_practice/model/movie_list_model.dart';
import 'package:rest_api_with_provider_practice/repository/home_repository.dart';

class HomeViewModel with ChangeNotifier{

  final _myRepo = HomeRepository();

  ApiResponse<MovieListModel> moviesList = ApiResponse.loading();

  setMovieList(ApiResponse<MovieListModel> response){
    moviesList = response;
    notifyListeners();
  }

  Future<void> fetchMoviesList() async {
    setMovieList(ApiResponse.loading());

    _myRepo.fetchMoviesListApi().then((val) {
      print(ApiResponse.completed(val));
      setMovieList(ApiResponse.completed(val));
    }).onError((error, stackTrace) {
      print("the error is ${ApiResponse.error(error.toString())}");
      setMovieList(ApiResponse.error(error.toString()));
    });
  }

}