import 'package:flutter/material.dart';
import 'package:news_app/base/bootstrap.dart';
import 'package:news_app/base/router/router.dart';
import 'package:news_app/features/top_articles_feature/top_articles_feature.dart';

void main() async {
  await Bootstrap.start();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => routerFeatures(settings)[settings.name],
      initialRoute: TopArticleRoutes.topArticles,
    );
  }
}
