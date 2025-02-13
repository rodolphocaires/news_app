import 'package:either_dart/either.dart';
import 'package:news_app/features/top_articles_feature/top_articles_feature.dart';
import 'package:news_app/utils/failure.dart';

abstract class ArticlesRepository {
  Future<Either<Failure, List<ArticleEntity>>> getTopHeadlines();

  Future<Either<Failure, List<ArticleEntity>>> getFavoriteArticles();

  Future<Either<Failure, List<ArticleEntity>>> addFavoriteArticles(
    ArticleEntity articleEntity,
  );

  Future<Either<Failure, List<ArticleEntity>>> deleteFromFavoriteArticles(
    ArticleEntity articleEntity,
  );
}
