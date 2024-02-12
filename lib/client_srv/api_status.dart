class Success {
  Success({required this.response, this.code});
  int? code;
  Object response;
}

class Failur {
  Failur({required this.errorResponse, required this.code});
  int code;
  Object errorResponse;
}
