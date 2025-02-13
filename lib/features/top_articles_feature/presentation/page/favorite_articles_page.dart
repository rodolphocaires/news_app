import 'package:flutter/material.dart';
import 'package:news_app/features/shared/shared.dart';
import 'package:news_app/features/top_articles_feature/top_articles_feature.dart';

class FavoriteArticlesPage extends StatefulWidget {
  const FavoriteArticlesPage({
    super.key,
    required this.favoriteArticlesStream,
  });

  final FavoriteArticlesStream favoriteArticlesStream;

  @override
  State<FavoriteArticlesPage> createState() => _FavoriteArticlesPageState();
}

class _FavoriteArticlesPageState extends State<FavoriteArticlesPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Favorite Articles')),
        body: StreamBuilder(
          stream: widget.favoriteArticlesStream.stream$,
          builder: (context, snapshot) {
            List<ArticleEntity> listArticles = snapshot.data ?? [];

            if (listArticles.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text('No favorite articles yet'),
                ),
              );
            }
            return ListView.builder(
              itemCount: listArticles.length,
              itemBuilder: (context, index) {
                final article = listArticles[index];

                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 12.0,
                    left: 12.0,
                    right: 12.0,
                  ),
                  child: CardInfo(
                    onTap: () => _navigateToArticleDetails(article),
                    author: article.author,
                    titleNews: article.title,
                    sourceName: article.sourceName,
                    imageUrl: article.urlToImage,
                  ),
                );
              },
            );
          },
        ),
      );

  Future<void> _navigateToArticleDetails(ArticleEntity articleEntity) async {
    await Navigator.pushNamed(
      context,
      TopArticleRoutes.articlesDetails,
      arguments: articleEntity,
    );
  }
}
