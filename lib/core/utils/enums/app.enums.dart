enum AnimateType { slideLeft, slideUp, slideDown, slideRight }

enum SlideDirection { leftToRight, rightToLeft }

enum IconDirection { left, right }

enum LoadingState { loading, completed, error, empty }

//to add remaining
enum RequestType { get, post, put, patch, delete }

enum Channel { sms, email }

enum ReadStatus { read, unread, queued }

enum ChatStatus { online, offline, away }

enum UsernameStatus { empty, available, taken }

enum FileType { video, image, unknown }

enum Direction { left, right }

enum ProductType { pensions, insurance, corporate }

enum DateDiffUnit { days, months, years }

enum PolicyStatus { active, inactive, lapsed }

enum PaymentStatus {
  success('Success'),
  failed('Failed'),
  pending('Pending');

  final String value;
  const PaymentStatus(this.value);

  @override
  String toString() => value;
}

enum BadgeType { report, beneficiary, contribution, maintenance }

// enum Environment { dev, prod }
enum SchemeType { anchor, prestige, aspire }

enum ContentType { article, video }

enum ConnectivityStatus { connected, disconnected }
