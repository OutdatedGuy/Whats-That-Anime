enum ResultStatus { success, warning, error }

class MyResult {
  ResultStatus status;
  String code;
  String? message, url;

  MyResult({required this.status, required this.code, this.message, this.url});
}
