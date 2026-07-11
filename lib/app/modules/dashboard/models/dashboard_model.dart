import '../../transaction/model/transaction_model.dart';

class DashboardResponse {
  final bool success;
  final DashboardData data;

  DashboardResponse({
    required this.success,
    required this.data,
  });

  factory DashboardResponse.fromJson(Map<String, dynamic> json) {
    return DashboardResponse(
      success: json["success"] ?? false,
      data: DashboardData.fromJson(json["data"]),
    );
  }
}

class DashboardData {
  final DashboardOverview overview;
  final String aiInsight;
  final List<TransactionModel> recentTransactions;
  final List<ExpenseCategory> expenseByCategory;
  final List<CashflowChart> cashflowChart;

  DashboardData({
    required this.overview,
    required this.aiInsight,
    required this.recentTransactions,
    required this.expenseByCategory,
    required this.cashflowChart,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      overview: DashboardOverview.fromJson(json["overview"]),

      aiInsight: json["ai_insight"] ?? "",

      recentTransactions:
          (json["recent_transactions"] as List<dynamic>?)
                  ?.map((e) => TransactionModel.fromJson(e))
                  .toList() ??
              [],

      expenseByCategory:
          (json["expense_by_category"] as List<dynamic>?)
                  ?.map((e) => ExpenseCategory.fromJson(e))
                  .toList() ??
              [],

      cashflowChart:
          (json["cashflow_chart"] as List<dynamic>?)
                  ?.map((e) => CashflowChart.fromJson(e))
                  .toList() ??
              [],
    );
  }
}

class DashboardOverview {
  final double totalBalance;
  final double previousBalance;
  final double balanceChangePercent;
  final String balanceChangeType;

  final double monthlyIncome;
  final double monthlyExpense;
  final double totalInvestment;

  final List<WalletModel> walletSummary;

  final int financialScore;

  DashboardOverview({
    required this.totalBalance,
    required this.previousBalance,
    required this.balanceChangePercent,
    required this.balanceChangeType,
    required this.monthlyIncome,
    required this.monthlyExpense,
    required this.totalInvestment,
    required this.walletSummary,
    required this.financialScore,
  });

  factory DashboardOverview.fromJson(Map<String, dynamic> json) {
    return DashboardOverview(
      totalBalance:
          double.tryParse(json["total_balance"].toString()) ?? 0,

      previousBalance:
          double.tryParse(json["previous_balance"].toString()) ?? 0,

      balanceChangePercent:
          double.tryParse(json["balance_change_percent"].toString()) ?? 0,

      balanceChangeType:
          json["balance_change_type"]?.toString() ?? "stable",

      monthlyIncome:
          double.tryParse(json["monthly_income"].toString()) ?? 0,

      monthlyExpense:
          double.tryParse(json["monthly_expense"].toString()) ?? 0,

      totalInvestment:
          double.tryParse(json["total_investment"].toString()) ?? 0,

      walletSummary:
          (json["wallet_summary"] as List<dynamic>?)
                  ?.map((e) => WalletModel.fromJson(e))
                  .toList() ??
              [],

      financialScore:
          json["financial_score"] ?? 0,
    );
  }
}

class ExpenseCategory {
  final int categoryId;
  final double total;
  final CategorySummary? category;

  ExpenseCategory({
    required this.categoryId,
    required this.total,
    this.category,
  });

  factory ExpenseCategory.fromJson(Map<String, dynamic> json) {
    return ExpenseCategory(
      categoryId: json["category_id"] ?? 0,
      total: double.tryParse(json["total"].toString()) ?? 0,
      category: json["category"] != null
          ? CategorySummary.fromJson(json["category"])
          : null,
    );
  }
}

class CategorySummary {
  final int id;
  final String categoryName;
  final String categoryType;
  final String icon;
  final String color;

  CategorySummary({
    required this.id,
    required this.categoryName,
    required this.categoryType,
    required this.icon,
    required this.color,
  });

  factory CategorySummary.fromJson(Map<String, dynamic> json) {
    return CategorySummary(
      id: json["id"] ?? 0,
      categoryName: json["category_name"] ?? "",
      categoryType: json["category_type"] ?? "",
      icon: json["icon"] ?? "",
      color: json["color"] ?? "#000000",
    );
  }
}

class CashflowChart {
  final DateTime date;
  final double income;
  final double expense;

  CashflowChart({
    required this.date,
    required this.income,
    required this.expense,
  });

  factory CashflowChart.fromJson(Map<String, dynamic> json) {
    return CashflowChart(
      date: DateTime.parse(json["date"]),

      income:
          double.tryParse(json["income"].toString()) ?? 0,

      expense:
          double.tryParse(json["expense"].toString()) ?? 0,
    );
  }
}