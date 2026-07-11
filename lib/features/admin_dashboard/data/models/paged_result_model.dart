import 'audit_log_model.dart';

/// Generic paged result - manually deserialized since json_serializable
/// doesn't support generic type parameters with code gen easily.
class PagedResult<T> {
  final List<T> items;
  final int pageNumber;
  final int pageSize;
  final int totalCount;
  final int totalPages;

  const PagedResult({
    required this.items,
    required this.pageNumber,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
  });

  factory PagedResult.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return PagedResult<T>(
      items: (json['items'] as List<dynamic>)
          .map((e) => fromJsonT(e))
          .toList(),
      pageNumber: json['pageNumber'] as int? ?? 1,
      pageSize: json['pageSize'] as int? ?? 10,
      totalCount: json['totalCount'] as int? ?? 0,
      totalPages: json['totalPages'] as int? ?? 0,
    );
  }

  bool get hasNextPage => pageNumber < totalPages;
  bool get hasPreviousPage => pageNumber > 1;
}

/// Typed factory for AuditLog pages
class AuditLogPagedResult extends PagedResult<AuditLogModel> {
  AuditLogPagedResult({
    required super.items,
    required super.pageNumber,
    required super.pageSize,
    required super.totalCount,
    required super.totalPages,
  });

  factory AuditLogPagedResult.fromJson(Map<String, dynamic> json) {
    return AuditLogPagedResult(
      items: (json['items'] as List<dynamic>)
          .map((e) => AuditLogModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageNumber: json['pageNumber'] as int? ?? 1,
      pageSize: json['pageSize'] as int? ?? 10,
      totalCount: json['totalCount'] as int? ?? 0,
      totalPages: json['totalPages'] as int? ?? 0,
    );
  }
}
