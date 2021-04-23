import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';

@JsonSerializable()
class News {
  final String description;
  final DateTime? createdAt;
  final String? user;
  final String? userTitle;
  final String? image;

  News(this.description, this.createdAt, this.user, this.userTitle, this.image);

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);
  Map<String, dynamic> toJson() => _$NewsToJson(this);
}