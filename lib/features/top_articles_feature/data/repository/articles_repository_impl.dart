import 'package:either_dart/either.dart';
import 'package:news_app/features/top_articles_feature/top_articles_feature.dart';
import 'package:news_app/utils/failure.dart';

class ArticlesRepositoryImpl implements ArticlesRepository {
  ArticlesRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
  });

  final ArticlesRemoteDatasource remoteDatasource;
  final ArticlesLocalDatasource localDatasource;

  @override
  Future<Either<Failure, List<ArticleEntity>>> getTopHeadlines() async {
    try {
      final result = await remoteDatasource.getTopHeadlines();
      if (result.isNotEmpty) {
        return Right(result);
      }
      return Left(GetTopHeadlinesEmptyListFailure());
    } catch (e) {
      return Left(GetTopHeadlinesCatchFailure());
    }
  }

  @override
  Future<Either<Failure, List<ArticleEntity>>> getFavoriteArticles() async {
    try {
      final result = await localDatasource.getFavoriteArticles();
      return result.isNotEmpty
          ? Right(result)
          : Left(GetFavoriteArticlesEmptyListFailure());
    } catch (e) {
      return Left(GetFavoriteArticlesCatchFailure());
    }
  }

  @override
  Future<Either<Failure, List<ArticleEntity>>> addFavoriteArticles(
    ArticleEntity articleEntity,
  ) async {
    try {
      final result = await localDatasource
          .addFavoriteArticles(ArticleModel.fromEntity(articleEntity));
      return Right(result);
    } on AddFavoriteArticlesException {
      return Left(AddFavoriteArticlesNotAddedFailure());
    } catch (e) {
      return Left(AddFavoriteArticlesCatchFailure());
    }
  }

  @override
  Future<Either<Failure, List<ArticleEntity>>> deleteFromFavoriteArticles(
    ArticleEntity articleEntity,
  ) async {
    try {
      final result = await localDatasource
          .deleteFromFavoriteArticles(ArticleModel.fromEntity(articleEntity));
      return Right(result);
    } on DeleteFromFavoriteArticlesException {
      return Left(DeleteFromFavoriteArticlesNotRemovedFailure());
    } catch (e) {
      return Left(DeleteFromFavoriteArticlesCatchFailure());
    }
  }
}
