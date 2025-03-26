class NotificationModel {
  String? id;
  String? notifyUserId;
  String? title;
  String? body;
  String? imageUrl;
  NotificationType? notificationType;
  String? createdDate;
  bool? isRead;

  NotificationModel({
    this.id,
    this.notifyUserId,
    this.title,
    this.body,
    this.imageUrl,
    this.notificationType,
    this.createdDate,
    this.isRead,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notifyUserId = json['notifyUserId'];
    title = json['title'];
    body = json['body'];
    imageUrl = json['imageUrl'];
    notificationType = json['notificationType'] != null
        ? NotificationType.fromJson(json['notificationType'])
        : null;
    createdDate = json['createdDate'];
    isRead = json['isRead'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['notifyUserId'] = notifyUserId;
    data['title'] = title;
    data['body'] = body;
    data['imageUrl'] = imageUrl;
    data['notificationType'] = notificationType?.toJson();
    data['createdDate'] = createdDate;
    data['isRead'] = isRead;
    return data;
  }
}

class NotificationType {
  String? fromUserId;
  String? toUserId;
  String? postId;
  String? followerId;
  String? type;
  String? opinionId;
  String? subCommentId;
  String? gymRequesterId;

  NotificationType({
    this.fromUserId,
    this.toUserId,
    this.postId,
    this.followerId,
    this.type,
    this.opinionId,
    this.subCommentId,
    this.gymRequesterId,
  });

  NotificationType.fromJson(Map<String, dynamic> json) {
    fromUserId = json['fromUserId'];
    toUserId = json['toUserId'];
    postId = json['postId'];
    followerId = json['followerId'];
    type = json['type'];
    opinionId = json['opinionId'];
    subCommentId = json['subCommentId'];
    gymRequesterId = json['gymRequesterId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fromUserId'] = fromUserId;
    data['toUserId'] = toUserId;
    data['postId'] = postId;
    data['followerId'] = followerId;
    data['type'] = type;
    data['opinionId'] = opinionId;
    data['subCommentId'] = subCommentId;
    data['gymRequesterId'] = gymRequesterId;
    return data;
  }
}
