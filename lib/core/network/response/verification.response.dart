class VerificationResponse {
  String? verificationUrl;
  String? sessionId;
  String? expiresAt;

  VerificationResponse({this.verificationUrl, this.sessionId, this.expiresAt});

  VerificationResponse.fromJson(Map<String, dynamic> json) {
    verificationUrl = json['verification_url'];
    sessionId = json['session_id'];
    expiresAt = json['expires_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['verification_url'] = verificationUrl;
    data['session_id'] = sessionId;
    data['expires_at'] = expiresAt;
    return data;
  }
}
