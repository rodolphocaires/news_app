import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/features/shared/shared.dart';
import 'package:news_app/features/top_articles_feature/top_articles_feature.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetailsPage extends StatefulWidget {
  const ArticleDetailsPage({
    super.key,
    required this.articleEntity,
    required this.favoriteArticlesStream,
    required this.addFavoriteArticles,
    required this.deleteFromFavoriteArticles,
  });

  final ArticleEntity articleEntity;
  final FavoriteArticlesStream favoriteArticlesStream;
  final AddFavoriteArticles addFavoriteArticles;
  final DeleteFromFavoriteArticles deleteFromFavoriteArticles;

  @override
  State<ArticleDetailsPage> createState() => _ArticleDetailsPageState();
}

class _ArticleDetailsPageState extends State<ArticleDetailsPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Article'),
          actions: [
            StreamBuilder(
              stream: widget.favoriteArticlesStream.stream$,
              builder: (context, snapshot) {
                bool isFavorite = false;

                List<ArticleEntity> listArticles = snapshot.data ?? [];

                if (listArticles.isNotEmpty) {
                  isFavorite = listArticles
                      .any((element) => element == widget.articleEntity);
                }

                return IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
                  onPressed: () => _onTapFavoriteIcon(
                    articleEntity: widget.articleEntity,
                    isFavorite: isFavorite,
                  ),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.45,
                  width: double.infinity,
                  child: ImageNetwork(
                    imageUrl: widget.articleEntity.urlToImage,
                    defaultIconColor: Colors.grey,
                  ),
                ),
              ),
              PaddingWithText(
                text: _getDateTimeFormatted(widget.articleEntity.publishedAt),
                fontSize: 14,
              ),
              PaddingWithText(
                text: widget.articleEntity.sourceName,
                fontSize: 24,
              ),
              PaddingWithText(
                text: widget.articleEntity.author,
                textPrefix: 'Author:',
                fontSize: 14,
              ),
              PaddingWithText(
                text: widget.articleEntity.title,
                fontSize: 14,
              ),
              PaddingWithText(
                text: widget.articleEntity.description,
                fontSize: 14,
              ),
              if (widget.articleEntity.url.isNotEmpty)
                GestureDetector(
                  onTap: () => _onTapOpenUrl(widget.articleEntity.url),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12.0),
                    margin: const EdgeInsets.only(
                      top: 24.0,
                      left: 12.0,
                      right: 12.0,
                      bottom: 12.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'Check full article',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );

  String _getDateTimeFormatted(String dateTime) {
    if (dateTime.isEmpty) return '';
    final parsedDateTime = DateTime.parse(dateTime);
    DateFormat formatter = DateFormat('MM/dd/yyyy HH:mm');
    return formatter.format(parsedDateTime);
  }

  void _onTapOpenUrl(String url) {
    if (url.isNotEmpty) {
      launchUrl(Uri.parse(url));
    }
  }

  Future<void> _onTapFavoriteIcon({
    required ArticleEntity articleEntity,
    required bool isFavorite,
  }) async {
    if (isFavorite) {
      await widget.deleteFromFavoriteArticles(articleEntity);
    } else {
      await widget.addFavoriteArticles(articleEntity);
    }
  }
}
