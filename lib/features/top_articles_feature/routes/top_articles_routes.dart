import 'package:flutter/material.dart';
import 'package:news_app/base/injection/client/client.dart';
import 'package:news_app/base/router/router.dart';
import 'package:news_app/features/top_articles_feature/top_articles_feature.dart';
import 'package:provider/provider.dart';

class TopArticleRouter implements RouterClient {
  @override
  Map<String, dynamic> getRoutes(RouteSettings settings) => {
        TopArticleRoutes.topArticles: MaterialPageRoute(
            settings: settings,
            builder: (_) => ChangeNotifierProvider(
                  create: (_) => TopArticlesState(),
                  child: TopArticlesPage(
                    startBackgroundFetch: Injector.I.get(),
                    topArticlesState: Injector.I.get(),
                    getHeadlinesGroupedBySource: Injector.I.get(),
                    getFavoriteArticles: Injector.I.get(),
                  ),
                )),
        TopArticleRoutes.articlesDetails: MaterialPageRoute(
          settings: settings,
          builder: (_) => ArticleDetailsPage(
            articleEntity: settings.arguments as ArticleEntity,
            favoriteArticlesStream: Injector.I.get(),
            addFavoriteArticles: Injector.I.get(),
            deleteFromFavoriteArticles: Injector.I.get(),
          ),
        ),
        TopArticleRoutes.favoriteArticles: MaterialPageRoute(
          settings: settings,
          builder: (_) => FavoriteArticlesPage(
            favoriteArticlesStream: Injector.I.get(),
          ),
        ),
      };
}

class TopArticleRoutes {
  static const topArticles = 'top_articles';
  static const articlesDetails = 'articles_details';
  static const favoriteArticles = 'favorite_articles';
}
