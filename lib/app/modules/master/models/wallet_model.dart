class WalletResponse {
  final bool success;
  final List<WalletModel> data;

  WalletResponse({
    required this.success,
    required this.data,
  });

  factory WalletResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return WalletResponse(
      success: json['success'] ?? false,
      data: (json['data'] as List)
          .map(
            (e) => WalletModel.fromJson(e),
          )
          .toList(),
    );
  }
}

class WalletModel {
  final int id;
  final String uuid;
  final int userId;
  final String walletName;
  final String walletType;
  final int balance;
  final String currency;
  final String icon;
  final String color;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  WalletModel({
    required this.id,
    required this.uuid,
    required this.userId,
    required this.walletName,
    required this.walletType,
    required this.balance,
    required this.currency,
    required this.icon,
    required this.color,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  

  factory WalletModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return WalletModel(
      id: json['id'] ?? 0,
      uuid: json['uuid'] ?? '',
      userId: json['user_id'] ?? 0,
      walletName:
          json['wallet_name'] ?? '',
      walletType:
          json['wallet_type'] ?? '',
      balance: json['balance'] ?? 0,
      currency:
          json['currency'] ?? 'IDR',
      icon: json['icon'] ?? '',
      color: json['color'] ?? '',
      isActive:
          json['is_active'] ?? false,
      createdAt: DateTime.parse(
        json['created_at'],
      ),
      updatedAt: DateTime.parse(
        json['updated_at'],
      ),
    );
  }
}