class CategoryModel {
  final int id;
  final String uuid;
  final int? userId;
  final String categoryName;
  final String categoryType;
  final String? icon;
  final String? color;
  final bool isDefault;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  CategoryModel({
    required this.id,
    required this.uuid,
    required this.userId,
    required this.categoryName,
    required this.categoryType,
    required this.icon,
    required this.color,
    required this.isDefault,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      uuid: json['uuid'],
      userId: json['user_id'],
      categoryName: json['category_name'],
      categoryType: json['category_type'],
      icon: json['icon'],
      color: json['color'],
      isDefault: json['is_default'] == 1 || json['is_default'] == true,
      isActive: json['is_active'] == 1 || json['is_active'] == true,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uuid': uuid,
      'user_id': userId,
      'category_name': categoryName,
      'category_type': categoryType,
      'icon': icon,
      'color': color,
      'is_default': isDefault ? 1 : 0,
      'is_active': isActive ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

/// ===============================
/// CATEGORY RESPONSE WRAPPER
/// ===============================
class CategoryResponse {
  final bool success;
  final List<CategoryModel> data;

  CategoryResponse({
    required this.success,
    required this.data,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      success: json['success'] ?? false,
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => CategoryModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}