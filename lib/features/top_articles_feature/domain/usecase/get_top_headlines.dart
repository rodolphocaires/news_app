import 'package:either_dart/either.dart';
import 'package:news_app/features/top_articles_feature/top_articles_feature.dart';
import 'package:news_app/utils/failure.dart';

abstract class GetTopHeadlines {
  Future<Either<Failure, List<ArticleEntity>>> call();
}

class GetTopHeadlinesImpl implements GetTopHeadlines {
  GetTopHeadlinesImpl(this.repository);

  final ArticlesRepository repository;

  @override
  Future<Either<Failure, List<ArticleEntity>>> call() async =>
      await repository.getTopHeadlines();
}
