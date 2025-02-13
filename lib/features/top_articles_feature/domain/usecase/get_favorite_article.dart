import 'package:either_dart/either.dart';
import 'package:news_app/features/top_articles_feature/top_articles_feature.dart';
import 'package:news_app/utils/failure.dart';

abstract class GetFavoriteArticles {
  Future<Either<Failure, List<ArticleEntity>>> call();
}

class GetFavoriteArticlesImpl implements GetFavoriteArticles {
  GetFavoriteArticlesImpl({
    required this.repository,
    required this.favoriteArticlesStream,
  });

  final ArticlesRepository repository;
  final FavoriteArticlesStream favoriteArticlesStream;

  @override
  Future<Either<Failure, List<ArticleEntity>>> call() async {
    final result = await repository.getFavoriteArticles();
    if (result.isRight) {
      favoriteArticlesStream.updateArticles(result.right);
    }
    return result;
  }
}
