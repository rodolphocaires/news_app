import 'package:news_app/utils/failure.dart';

class GetTopHeadlinesEmptyListFailure extends Failure {}

class GetTopHeadlinesCatchFailure extends Failure {}

class GetFavoriteArticlesEmptyListFailure extends Failure {}

class GetFavoriteArticlesCatchFailure extends Failure {}

class AddFavoriteArticlesNotAddedFailure extends Failure {}

class AddFavoriteArticlesCatchFailure extends Failure {}

class DeleteFromFavoriteArticlesCatchFailure extends Failure {}

class DeleteFromFavoriteArticlesNotRemovedFailure extends Failure {}
