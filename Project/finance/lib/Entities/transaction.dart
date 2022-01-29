class Transaction {
  int id;
  String remark;
  String category;
  double amount;
  bool isExpense;
  DateTime dateTime;

  Transaction({
    required this.id,
    required this.remark,
    required this.category,
    required this.amount,
    required this.isExpense,
    required this.dateTime,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      remark: json['remark'],
      category: json['category'],
      amount: json['amount'] + 0.0,
      isExpense: json['is_expense'],
      dateTime: DateTime.parse(json['date_time']),
    );
  }
}
