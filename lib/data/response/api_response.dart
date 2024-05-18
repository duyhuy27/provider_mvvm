import 'package:arch_movie/data/response/status.dart';

class ApiResponse<T> {
  String? message;
  T? data;
  Status? status;

  ApiResponse(this.message, this.data, this.status);

  ApiResponse.loading() : status = Status.LOADING;

  ApiResponse.error() : status = Status.ERROR;

  ApiResponse.completed() : status = Status.COMPLETED;

  @override
  String toString() {
    // TODO: implement toString
    return 'Status: $status \n Message: $message \n Data: $data';
  }
}
