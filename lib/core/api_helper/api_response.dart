class ApiResponse<T> {
  final T? value;
  final bool success;
  final String message;

  ApiResponse({this.value, required this.success, required this.message});

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return ApiResponse(
      value: json['data'] != null ? fromJsonT(json['data']) : null,
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }
}
