import 'dart:convert';

class TransactionResponse {
  final bool success;
  final TransactionData data;

  TransactionResponse({
    required this.success,
    required this.data,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    return TransactionResponse(
      success: json['success'] ?? false,
      data: json['data'] != null
          ? TransactionData.fromJson(json['data'])
          : TransactionData.empty(),
    );
  }
}

class TransactionData {
  final int currentPage;
  final List<TransactionModel> transactions;
  final int total;
  final int perPage;
  final int from;
  final int to;
  final String? nextPageUrl;
  final String? prevPageUrl;

  TransactionData({
    required this.currentPage,
    required this.transactions,
    required this.total,
    required this.perPage,
    required this.from,
    required this.to,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  factory TransactionData.empty() {
    return TransactionData(
      currentPage: 1,
      transactions: [],
      total: 0,
      perPage: 0,
      from: 0,
      to: 0,
    );
  }

  factory TransactionData.fromJson(Map<String, dynamic> json) {
    return TransactionData(
      currentPage: json['current_page'] ?? 1,
      transactions: (json['data'] as List? ?? [])
          .map((e) => TransactionModel.fromJson(e))
          .toList(),
      total: json['total'] ?? 0,
      perPage: json['per_page'] ?? 0,
      from: json['from'] ?? 0,
      to: json['to'] ?? 0,
      nextPageUrl: json['next_page_url'],
      prevPageUrl: json['prev_page_url'],
    );
  }
}

class TransactionModel {
  final int id;
  final String uuid;
  final int userId;
  final int walletId;
  final int categoryId;

  final String transactionType;
  final String title;
  final String? description;
  final int amount;

  final DateTime transactionDate;
  final String? receiptImage;

  final AiNote? aiNote;

  final bool isRecurring;
  final bool isDeleted;

  final WalletModel wallet;
  final CategoryModel category;

  TransactionModel({
    required this.id,
    required this.uuid,
    required this.userId,
    required this.walletId,
    required this.categoryId,
    required this.transactionType,
    required this.title,
    this.description,
    required this.amount,
    required this.transactionDate,
    this.receiptImage,
    this.aiNote,
    required this.isRecurring,
    required this.isDeleted,
    required this.wallet,
    required this.category,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] ?? 0,
      uuid: json['uuid'] ?? '',
      userId: json['user_id'] ?? 0,
      walletId: json['wallet_id'] ?? 0,
      categoryId: json['category_id'] ?? 0,
      transactionType: json['transaction_type'] ?? '',
      title: json['title'] ?? '',
      description: json['description'],
      amount: _toInt(json['amount']),
      transactionDate: DateTime.tryParse(
            json['transaction_date']?.toString() ?? '',
          ) ??
          DateTime.now(),
      receiptImage: json['receipt_image'],
      aiNote: AiNote.fromDynamic(json['ai_note']),
      isRecurring: json['is_recurring'] ?? false,
      isDeleted: json['is_deleted'] ?? false,
      wallet: WalletModel.fromJson(json['wallet'] ?? {}),
      category: CategoryModel.fromJson(json['category'] ?? {}),
    );
  }

  static int _toInt(dynamic value) {
    if (value == null) return 0;
    return int.tryParse(value.toString()) ?? 0;
  }
}

class AiNote {
  final String ocrText;
  final List<AiItem> items;

  AiNote({
    required this.ocrText,
    required this.items,
  });

  factory AiNote.fromDynamic(dynamic raw) {
    if (raw == null) {
      return AiNote(ocrText: '', items: []);
    }

    try {
      final decoded = raw is String ? jsonDecode(raw) : raw;

      return AiNote(
        ocrText: decoded['ocr_text'] ?? '',
        items: (decoded['items'] as List? ?? [])
            .map((e) => AiItem.fromJson(e))
            .toList(),
      );
    } catch (_) {
      return AiNote(ocrText: '', items: []);
    }
  }
}

class AiItem {
  final String name;
  final int price;

  AiItem({
    required this.name,
    required this.price,
  });

  factory AiItem.fromJson(Map<String, dynamic> json) {
    return AiItem(
      name: json['name'] ?? '',
      price: TransactionModel._toInt(json['price']),
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
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      id: json['id'] ?? 0,
      uuid: json['uuid'] ?? '',
      userId: json['user_id'] ?? 0,
      walletName: json['wallet_name'] ?? '',
      walletType: json['wallet_type'] ?? '',
      balance: TransactionModel._toInt(json['balance']),
      currency: json['currency'] ?? 'IDR',
      icon: json['icon'] ?? '',
      color: json['color'] ?? '#000000',
      isActive: json['is_active'] ?? false,
    );
  }
}

class CategoryModel {
  final int id;
  final String uuid;
  final int? userId;
  final String categoryName;
  final String categoryType;
  final String icon;
  final String color;
  final bool isDefault;
  final bool isActive;

  CategoryModel({
    required this.id,
    required this.uuid,
    this.userId,
    required this.categoryName,
    required this.categoryType,
    required this.icon,
    required this.color,
    required this.isDefault,
    required this.isActive,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? 0,
      uuid: json['uuid'] ?? '',
      userId: json['user_id'],
      categoryName: json['category_name'] ?? '',
      categoryType: json['category_type'] ?? '',
      icon: json['icon'] ?? '',
      color: json['color'] ?? '#000000',
      isDefault: json['is_default'] ?? false,
      isActive: json['is_active'] ?? false,
    );
  }
}