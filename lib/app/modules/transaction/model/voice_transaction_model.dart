class VoiceTransactionResponse {
  final bool success;
  final VoiceTransactionData data;

  VoiceTransactionResponse({
    required this.success,
    required this.data,
  });

  factory VoiceTransactionResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return VoiceTransactionResponse(
      success: json['success'] ?? false,
      data: VoiceTransactionData.fromJson(
        json['data'],
      ),
    );
  }
}

class VoiceTransactionData {
  final String title;
  final String description;
  final int amount;
  final String wallet;
  final String category;
  final String transactionDate;

  VoiceTransactionData({
    required this.title,
    required this.description,
    required this.amount,
    required this.wallet,
    required this.category,
    required this.transactionDate,
  });

  factory VoiceTransactionData.fromJson(
    Map<String, dynamic> json,
  ) {
    return VoiceTransactionData(
      title: json['title'] ?? '',
      description:
          json['description'] ?? '',
      amount: json['amount'] ?? 0,
      wallet: json['wallet'] ?? 'Cash',
      category:
          json['category'] ?? 'Other',
      transactionDate:
          json['transaction_date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "amount": amount,
      "wallet": wallet,
      "category": category,
      "transaction_date":
          transactionDate,
    };
  }
}