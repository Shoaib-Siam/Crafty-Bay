class NetworkResponse {
  final bool success;
  final int statusCode;
  final Map<String, dynamic> body;
  final String errorMessage;

  NetworkResponse({
    required this.success,
    required this.statusCode,
    required this.body,
    required this.errorMessage,
  });
}
