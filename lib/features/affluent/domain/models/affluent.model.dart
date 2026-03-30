class Affluent {
  bool? isAffluent;
  String? tier;
  String? badge;
  String? description;

  Affluent({
    this.isAffluent,
    this.tier,
    this.badge,
    this.description,
  });

  Affluent copyWith({
    bool? isAffluent,
    String? tier,
    String? badge,
    String? description,
  }) {
    return Affluent(
      isAffluent: isAffluent ?? this.isAffluent,
      tier: tier ?? this.tier,
      badge: badge ?? this.badge,
      description: description ?? this.description,
    );
  }

  Affluent.fromJson(Map<String, dynamic> json) {
    isAffluent = json['is_affluent'];
    tier = json['tier'];
    badge = json['badge'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_affluent'] = isAffluent;
    data['tier'] = tier;
    data['badge'] = badge;
    data['description'] = description;
    return data;
  }
}
