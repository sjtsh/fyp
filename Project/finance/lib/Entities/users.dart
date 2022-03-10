class User {
  int id;
  String? email;
  String avatarURL;
  String name;
  double monthlyTargetSaving;
  double bankBalance;
  int? pinCode;
  DateTime dateTime;
  bool isDeactivated;
  String themePreference;

  User({
    required this.id,
    required this.avatarURL,
    required this.name,
    required this.monthlyTargetSaving,
    required this.bankBalance,
    this.pinCode,
    required this.dateTime,
    required this.isDeactivated,
    this.themePreference = "Light",
    this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      avatarURL: json["avatar"],
      name: json["name"],
      monthlyTargetSaving: json["monthly_target_saving"] + 0.0,
      bankBalance: json["bank_balance"] + 0.0,
      pinCode: json["pin_code"],
      dateTime: DateTime.parse(json["date_time"]),
      isDeactivated: json["is_deactivated"],
      themePreference: json['theme_preference'],
      email: json['email']
    );
  }
}
