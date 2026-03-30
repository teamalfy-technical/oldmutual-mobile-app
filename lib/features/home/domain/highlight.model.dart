class Highlight {
  final String title;
  final String? title2;
  final String thumbnail;
  final String image;
  final String? url;
  final String? heading;
  final String? description;

  final String? planDescription;
  final List<String>? benefits;

  final Function()? onQuoteTap;
  final Function()? onLearnMoreTap;

  Highlight({
    required this.title,
    required this.image,
    required this.thumbnail,
    this.title2,
    this.onQuoteTap,
    this.onLearnMoreTap,
    this.url,
    this.planDescription,
    this.benefits,
    this.heading,
    this.description,
  });
}
