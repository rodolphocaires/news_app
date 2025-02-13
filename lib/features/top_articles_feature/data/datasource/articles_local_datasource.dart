import 'dart:convert';

import 'package:news_app/core/local_storage_core/shared_preferences/shared_preferences.dart';
import 'package:news_app/features/top_articles_feature/top_articles_feature.dart';

abstract class ArticlesLocalDatasource {
  Future<List<ArticleModel>> getFavoriteArticles();

  Future<List<ArticleModel>> addFavoriteArticles(ArticleModel articleModel);

  Future<List<ArticleModel>> deleteFromFavoriteArticles(
    ArticleModel articleModel,
  );
}

class ArticlesLocalDatasourceImpl implements ArticlesLocalDatasource {
  ArticlesLocalDatasourceImpl(this.sharedPreferencesClient);

  final SharedPreferencesClient sharedPreferencesClient;

  static const favoriteArticlesKey = 'favoriteArticles';

  @override
  Future<List<ArticleModel>> getFavoriteArticles() async {
    final favorites =
        await sharedPreferencesClient.getString(favoriteArticlesKey);
    if (favorites != null && favorites.isNotEmpty) {
      final List<dynamic> favoriteList = json.decode(favorites);
      return favoriteList.map((e) => ArticleModel.fromMap(e)).toList();
    }
    return [];
  }

  @override
  Future<List<ArticleModel>> addFavoriteArticles(
    ArticleModel articleModel,
  ) async {
    final favorites = await getFavoriteArticles();
    favorites.add(articleModel);
    final result = await sharedPreferencesClient.setString(
      favoriteArticlesKey,
      json.encode(favorites.map((e) => e.toMap()).toList()),
    );
    if (result) return favorites;
    throw AddFavoriteArticlesException();
  }

  @override
  Future<List<ArticleModel>> deleteFromFavoriteArticles(
    ArticleModel articleModel,
  ) async {
    final favorites = await getFavoriteArticles();
    favorites.remove(articleModel);
    final result = await sharedPreferencesClient.setString(
      favoriteArticlesKey,
      json.encode(favorites.map((e) => e.toMap()).toList()),
    );
    if (result) return favorites;
    throw DeleteFromFavoriteArticlesException();
  }
}
