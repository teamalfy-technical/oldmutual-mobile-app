import 'package:oldmutual_pensions_app/features/affluent/domain/models/content.model.dart';

class BookmarkedContent {
  int? id;
  String? bookmarkedAt;
  Content? content;

  BookmarkedContent({
    this.id,
    this.bookmarkedAt,
    this.content,
  });

  BookmarkedContent copyWith({
    int? id,
    String? bookmarkedAt,
    Content? content,
  }) {
    return BookmarkedContent(
      id: id ?? this.id,
      bookmarkedAt: bookmarkedAt ?? this.bookmarkedAt,
      content: content ?? this.content,
    );
  }

  BookmarkedContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookmarkedAt = json['bookmarked_at'];
    content =
        json['content'] != null ? Content.fromJson(json['content']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bookmarked_at'] = bookmarkedAt;
    data['content'] = content?.toJson();
    return data;
  }
}
