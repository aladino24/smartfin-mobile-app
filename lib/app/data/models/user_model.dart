class UserModel {
  final bool success;
  final String message;
  final DataLogin? data;

  UserModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? DataLogin.fromJson(json['data'])
          : null,
    );
  }
}

class DataLogin {
  final String token;
  final UserData user;

  DataLogin({
    required this.token,
    required this.user,
  });

  factory DataLogin.fromJson(Map<String, dynamic> json) {
    return DataLogin(
      token: json['token'] ?? '',
      user: UserData.fromJson(json['user'] ?? {}),
    );
  }
}

class UserData {
  final int id;
  final String uuid;
  final String fullName;
  final String email;
  final String phone;
  final String avatar;
  final int monthlyIncome;
  final int financialLevel;
  final String financialPersonality;
  final String riskProfile;
  final String investmentGoal;
  final String targetExpense;
  final int surveyCompleted;
  final bool isPremium;
  final bool isActive;
  final DateTime? lastLoginAt;

  UserData({
    required this.id,
    required this.uuid,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.avatar,
    required this.monthlyIncome,
    required this.financialLevel,
    required this.financialPersonality,
    required this.riskProfile,
    required this.investmentGoal,
    required this.targetExpense,
    required this.surveyCompleted,
    required this.isPremium,
    required this.isActive,
    this.lastLoginAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] ?? 0,
      uuid: json['uuid'] ?? '',
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      avatar: json['avatar'] ?? '',
      monthlyIncome: json['monthly_income'] ?? 0,
      financialLevel: json['financial_level'] ?? 0,
      financialPersonality: json['financial_personality'] ?? '',
      riskProfile: json['risk_profile'] ?? '',
      investmentGoal: json['investment_goal'] ?? '',
      targetExpense: json['monthly_expense_target']?.toString() ?? '0',
      surveyCompleted: json['survey_completed'] ?? 0,
      isPremium: json['is_premium'] ?? false,
      isActive: json['is_active'] ?? false,
      lastLoginAt: json['last_login_at'] != null
          ? DateTime.tryParse(json['last_login_at'])
          : null,
    );
  }
}