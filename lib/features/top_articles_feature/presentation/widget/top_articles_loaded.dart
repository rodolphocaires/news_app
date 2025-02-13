import 'package:flutter/material.dart';
import 'package:news_app/features/shared/shared.dart';
import 'package:news_app/features/top_articles_feature/top_articles_feature.dart';
import 'package:rxdart/rxdart.dart';

class TopArticlesLoaded extends StatelessWidget {
  const TopArticlesLoaded({
    super.key,
    required this.valueStream,
    required this.onTap,
  });

  final ValueStream valueStream;
  final Future<void> Function(ArticleEntity articleEntity) onTap;

  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: valueStream,
        builder: (context, snapshot) {
          List<SourceArticlesEntity> listSources = snapshot.data ?? [];

          if (listSources.isEmpty) {
            return const SizedBox.shrink();
          }

          return SingleChildScrollView(
            child: Column(
              children: listSources
                  .map(
                    (source) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            source.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: source.articles.length,
                          itemBuilder: (context, index) {
                            final article = source.articles[index];

                            if (article.title
                                .toLowerCase()
                                .contains('removed')) {
                              return const SizedBox.shrink();
                            }

                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: 12.0,
                                left: 12.0,
                                right: 12.0,
                              ),
                              child: CardInfo(
                                onTap: () => onTap(article),
                                author: article.author,
                                titleNews: article.title,
                                sourceName: article.sourceName,
                                imageUrl: article.urlToImage,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          );
        },
      );
}
