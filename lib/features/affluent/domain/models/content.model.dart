class Content {
  int? id;
  int? categoryId;
  String? category;
  String? contentType;
  String? title;
  String? description;
  String? content;
  String? mediaUrl;
  String? thumbnail;
  String? duration;
  int? isPublished;
  String? publishedAt;
  String? slug;
  String? createdAt;
  String? updatedAt;

  Content({
    this.id,
    this.categoryId,
    this.category,
    this.contentType,
    this.title,
    this.description,
    this.content,
    this.mediaUrl,
    this.thumbnail,
    this.duration,
    this.isPublished,
    this.publishedAt,
    this.slug,
    this.createdAt,
    this.updatedAt,
  });

  Content copyWith({
    int? id,
    int? categoryId,
    String? category,
    String? contentType,
    String? title,
    String? description,
    String? content,
    String? mediaUrl,
    String? thumbnail,
    String? duration,
    int? isPublished,
    String? publishedAt,
    String? slug,
    String? createdAt,
    String? updatedAt,
  }) {
    return Content(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      category: category ?? this.category,
      contentType: contentType ?? this.contentType,
      title: title ?? this.title,
      description: description ?? this.description,
      content: content ?? this.content,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      thumbnail: thumbnail ?? this.thumbnail,
      duration: duration ?? this.duration,
      isPublished: isPublished ?? this.isPublished,
      publishedAt: publishedAt ?? this.publishedAt,
      slug: slug ?? this.slug,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Content.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    category = json['category'];
    contentType = json['content_type'];
    title = json['title'];
    description = json['description'];
    content = json['content'];
    mediaUrl = json['media_url'];
    thumbnail = json['thumbnail'];
    duration = json['duration'];
    isPublished = json['is_published'];
    publishedAt = json['published_at'];
    slug = json['slug'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_id'] = categoryId;
    data['category'] = category;
    data['content_type'] = contentType;
    data['title'] = title;
    data['description'] = description;
    data['content'] = content;
    data['media_url'] = mediaUrl;
    data['thumbnail'] = thumbnail;
    data['duration'] = duration;
    data['is_published'] = isPublished;
    data['published_at'] = publishedAt;
    data['slug'] = slug;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
