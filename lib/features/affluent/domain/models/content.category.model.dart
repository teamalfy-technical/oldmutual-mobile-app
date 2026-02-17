class ContentCategory {
  int? id;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;

  ContentCategory({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  ContentCategory copyWith({
    int? id,
    String? name,
    String? description,
    String? createdAt,
    String? updatedAt,
  }) {
    return ContentCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  ContentCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
