import 'package:news_app/features/top_articles_feature/top_articles_feature.dart';
import 'package:rxdart/rxdart.dart';

class FavoriteArticlesStream {
  final BehaviorSubject<List<ArticleEntity>> articleSubject = BehaviorSubject.seeded([]);

  ValueStream get stream$ => articleSubject.stream;

  void updateArticles(List<ArticleEntity> updates) {
    articleSubject.add(updates);
  }
}