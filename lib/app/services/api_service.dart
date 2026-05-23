import 'dart:convert';
import 'package:http/http.dart' as http;

import '../modules/master/models/category_model.dart';
import '../modules/transaction/model/create_transaction_response.dart';
import '../modules/transaction/model/voice_transaction_model.dart';
import '../modules/master/models/wallet_model.dart';

class ApiService {
  final String baseUrl = "https://unsaved-broaden-bazooka.ngrok-free.dev/api/v1";

  Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final url = Uri.parse("$baseUrl/login");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );


    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data;
    } else {
      throw Exception(data["message"] ?? "Login failed");
    }
  }


  Future<void> logout(String token) async {
      final url = Uri.parse("$baseUrl/logout");

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode != 200) {
        throw Exception("Logout gagal");
      }
    }

    Future<Map<String, dynamic>> getTransactions(String token) async {
      final url = Uri.parse("$baseUrl/transactions");

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return data;
      } else {
        throw Exception(data["message"] ?? "Failed load transactions");
      }
  }

  Future<Map<String, dynamic>> register(
    String fullName,
    String email,
    String phone,
    String password,
  ) async {
    final url = Uri.parse("$baseUrl/register");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode({
        "full_name": fullName,
        "email": email,
        "phone": phone,
        "password": password,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 ||
        response.statusCode == 201) {
      return data;
    } else {
      throw Exception(
        data["message"] ?? "Register failed",
      );
    }
  }

Future<VoiceTransactionResponse>
  parseVoice(String text, String token, String tipe) async {
    final response = await http.post(
      Uri.parse("$baseUrl/transactions/voice"),

      headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
      },

      body: jsonEncode({
        "text": text,
        'tipe': tipe,
      }),
    );

    if (response.statusCode == 200) {
      final json =
          jsonDecode(response.body);

      return VoiceTransactionResponse
          .fromJson(json);
    } else {
      throw Exception(
        'Failed parse voice',
      );
    }
  }

  // wallet
  Future<List<WalletModel>> getWallets(
    String token,
  ) async {
    final response = await http.get(
      Uri.parse("$baseUrl/wallets"),
      headers: {
        "Accept": "application/json",
        "Authorization":
            "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(
        response.body,
      );

      final result =
          WalletResponse.fromJson(json);

      return result.data;
    } else {
      throw Exception(
        'Failed load wallets',
      );
    }
  }

  // category
  Future<List<CategoryModel>> getCategories(
    String token,
  ) async {
    final response = await http.get(
      Uri.parse("$baseUrl/categories"),
      headers: {
        "Accept": "application/json",
        "Authorization":
            "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(
        response.body,
      );

      final result =
          CategoryResponse.fromJson(json);

      return result.data;
    } else {
      throw Exception(
        'Failed load categories',
      );
    }
  }

   Future<CreateTransactionResponse> createTransaction(
    Map<String, dynamic> body,
    String? token,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/transactions"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return CreateTransactionResponse.fromJson(data);
      } else {
        return CreateTransactionResponse(
          success: false,
          message: data['message'] ?? 'Failed to create transaction',
        );
      }
    } catch (e) {
      return CreateTransactionResponse(
        success: false,
        message: e.toString(),
      );
    }
  }
}