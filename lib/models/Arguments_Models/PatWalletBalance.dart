class PatWalletBalance {
  dynamic balance;
  String activationDate;
  PatWalletBalance({required this.balance, required this.activationDate});
  factory PatWalletBalance.fromjson(jsonData) {
    return PatWalletBalance(
        balance: jsonData['balance'],
        activationDate: jsonData['wallet_activated_at']);
  }
}
