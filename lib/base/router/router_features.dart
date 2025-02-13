import 'package:flutter/material.dart';
import 'package:news_app/features/top_articles_feature/top_articles_feature.dart';

Map<String, dynamic> routerFeatures(RouteSettings settings) => {
  ...TopArticleRouter().getRoutes(settings),
};
