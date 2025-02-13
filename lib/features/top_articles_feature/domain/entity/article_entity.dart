import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable {
  const ArticleEntity({
    this.sourceId = '',
    this.sourceName = '',
    this.author = '',
    this.title = '',
    this.description = '',
    this.url = '',
    this.urlToImage = '',
    this.publishedAt = '',
    this.content = '',
  });

  final String sourceId;
  final String sourceName;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  @override
  List<Object?> get props => [
        sourceId,
        sourceName,
        author,
        title,
        description,
        url,
        urlToImage,
        publishedAt,
        content,
      ];

  ArticleEntity copyWith({
    String? sourceId,
    String? sourceName,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    String? publishedAt,
    String? content,
  }) =>
      ArticleEntity(
        sourceId: sourceId ?? this.sourceId,
        sourceName: sourceName ?? this.sourceName,
        author: author ?? this.author,
        title: title ?? this.title,
        description: description ?? this.description,
        url: url ?? this.url,
        urlToImage: urlToImage ?? this.urlToImage,
        publishedAt: publishedAt ?? this.publishedAt,
        content: content ?? this.content,
      );
}
