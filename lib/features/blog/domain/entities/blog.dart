class Blog {
  final String id;
  final String posterId;
  final String title;
  final String content;
  final String imageURL;
  final List<String> topics;
  final DateTime updatedAt;

  Blog(
      {required this.id,
      required this.posterId,
      required this.title,
      required this.content,
      required this.imageURL,
      required this.topics,
      required this.updatedAt,});     
}
