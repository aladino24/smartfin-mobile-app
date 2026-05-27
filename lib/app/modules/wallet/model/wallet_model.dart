class WalletModel {
  final int id;
  final String walletName;
  final String walletType;
  final double balance;
  final String color;
  final String icon;

  WalletModel({
    required this.id,
    required this.walletName,
    required this.walletType,
    required this.balance,
    required this.color,
    required this.icon,
  });
}