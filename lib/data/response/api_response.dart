import 'package:rest_api_with_provider_practice/data/response/status.dart';

class ApiResponse<T> {
  T? data;
  String? message;
  Status? status;
  ApiResponse({this.data, this.message, this.status});

  ApiResponse.loading() : status = Status.LOADING;
  ApiResponse.completed(this.data) : status = Status.SUCCESS;
  ApiResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }

}