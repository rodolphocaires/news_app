import 'package:either_dart/either.dart';
import 'package:news_app/features/top_articles_feature/top_articles_feature.dart';
import 'package:news_app/utils/failure.dart';

abstract class DeleteFromFavoriteArticles {
  Future<Either<Failure, List<ArticleEntity>>> call(
    ArticleEntity articleEntity,
  );
}

class DeleteFromFavoriteArticlesImpl implements DeleteFromFavoriteArticles {
  DeleteFromFavoriteArticlesImpl({
    required this.repository,
    required this.favoriteArticlesStream,
  });

  final ArticlesRepository repository;
  final FavoriteArticlesStream favoriteArticlesStream;

  @override
  Future<Either<Failure, List<ArticleEntity>>> call(
    ArticleEntity articleEntity,
  ) async {
    final result = await repository.deleteFromFavoriteArticles(articleEntity);
    if (result.isRight) {
      favoriteArticlesStream.updateArticles(result.right);
    }
    return result;
  }
}
