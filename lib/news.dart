class News {
  final String description;
  final DateTime createdAt;
  final String user;
  final String userTitle;
  final String image;
  List<String> urls = [];

  News(this.description, this.createdAt, this.user, this.userTitle, this.image);
}