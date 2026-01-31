
import 'package:equatable/equatable.dart';

class Meme extends Equatable {
  Meme({
    required this.postLink,
    required this.subreddit,
    required this.title,
    required this.nsfw,
    required this.url,
    required this.spoiler,
    required this.author,
    required this.ups,
    required this.preview,
  });

  final String postLink;
  final String subreddit;
  final String title;
  final bool nsfw;
  final String url;
  final bool spoiler;
  final String author;
  final int ups;
  final List<String> preview;

  Meme copyWith({
    String? postLink,
    String? subreddit,
    String? title,
    bool? nsfw,
    String? url,
    bool? spoiler,
    String? author,
    int? ups,
    List<String>? preview,
  }) {
    return Meme(
      postLink: postLink ?? this.postLink,
      subreddit: subreddit ?? this.subreddit,
      title: title ?? this.title,
      nsfw: nsfw ?? this.nsfw,
      url: url ?? this.url,
      spoiler: spoiler ?? this.spoiler,
      author: author ?? this.author,
      ups: ups ?? this.ups,
      preview: preview ?? this.preview,
    );
  }

  factory Meme.fromJson(Map<String, dynamic> json){
    return Meme(
      postLink: json["postLink"] ?? "",
      subreddit: json["subreddit"] ?? "",
      title: json["title"] ?? "",
      nsfw: json["nsfw"] ?? false,
      url: json["url"] ?? "",
      spoiler: json["spoiler"] ?? false,
      author: json["author"] ?? "",
      ups: json["ups"] ?? 0,
      preview: List<String>.from(json["preview"] ?? const []),
    );
  }

  Map<String, dynamic> toJson() => {
    "postLink": postLink,
    "subreddit": subreddit,
    "title": title,
    "nsfw": nsfw,
    "url": url,
    "spoiler": spoiler,
    "author": author,
    "ups": ups,
    "preview": preview.map((x) => x).toList(),
  };

  @override
  List<Object?> get props => [
    postLink, subreddit, title, nsfw, url, spoiler, author, ups, preview, ];
}
