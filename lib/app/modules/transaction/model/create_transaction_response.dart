import 'transaction_model.dart';

class CreateTransactionResponse {
  final bool success;
  final String? message;
  final TransactionModel? data;

  CreateTransactionResponse({
    required this.success,
    this.message,
    this.data,
  });

  factory CreateTransactionResponse.fromJson(Map<String, dynamic> json) {
    return CreateTransactionResponse(
      success: json['success'] ?? false,
      message: json['message'],
      data: json['data'] != null
          ? TransactionModel.fromJson(json['data'])
          : null,
    );
  }
}