import 'package:equatable/equatable.dart';
import 'package:news_app/features/top_articles_feature/top_articles_feature.dart';

class SourceArticlesEntity extends Equatable {
  const SourceArticlesEntity({
    this.id = '',
    this.name = '',
    this.articles = const [],
  });

  final String id;
  final String name;
  final List<ArticleEntity> articles;

  @override
  List<Object?> get props => [
        id,
        name,
        articles,
      ];

  SourceArticlesEntity copyWith({
    String? id,
    String? name,
    List<ArticleEntity>? articles,
  }) =>
      SourceArticlesEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        articles: articles ?? this.articles,
      );
}
