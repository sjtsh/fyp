class Avatar {
  final int avatarID;
  final String avatar_url;
  final String gender;
  final int minAgeEstimation;
  final int maxAgeEstimation;

  Avatar(
    this.avatarID,
    this.avatar_url,
    this.gender,
    this.minAgeEstimation,
    this.maxAgeEstimation,
  );

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(
      json["id"],
      json["avatar_url"],
      json["gender"],
      json["min_age_estimation"],
      json["max_age_estimation"],
    );
  }
}
