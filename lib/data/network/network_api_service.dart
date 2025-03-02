import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../app_exceptions.dart';
import 'base_api_service.dart';

class NetworkApiService extends BaseApiService {
  @override
  Future getPostApiResponse(String url,dynamic data) async{
    dynamic responseJson;
    try{
      Response response = await post(
          Uri.parse(url),
          body: data).timeout(Duration(seconds: 10)
      );
      responseJson = returnResponse(response);
    }on SocketException{
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  @override
  Future getGetApiResponse(String url) async{
    dynamic responseJson;
    try{
      final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
    }on SocketException{
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch(response.statusCode){
      case 200:
        dynamic responseJson = response.body;
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException("Error occurred while communicating with server with status code ${response.statusCode}");
    }
  }
}