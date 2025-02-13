import 'package:flutter/material.dart';
import 'package:news_app/features/top_articles_feature/top_articles_feature.dart';
import 'package:provider/provider.dart';

class TopArticlesPage extends StatefulWidget {
  const TopArticlesPage({
    super.key,
    required this.startBackgroundFetch,
    required this.getHeadlinesGroupedBySource,
    required this.topArticlesState,
    required this.getFavoriteArticles,
  });

  final StartBackgroundFetch startBackgroundFetch;
  final GetHeadlinesGroupedBySource getHeadlinesGroupedBySource;
  final TopArticlesStream topArticlesState;
  final GetFavoriteArticles getFavoriteArticles;

  @override
  State<TopArticlesPage> createState() => _TopArticlesPageState();
}

class _TopArticlesPageState extends State<TopArticlesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _startBackgroundFetch();

      final provider = context.read<TopArticlesState>();
      await _fetchArticles(
        updatePageState: provider.updatePageState,
      );
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Top Articles'),
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: _navigateToFavorites,
            ),
          ],
        ),
        body: Consumer<TopArticlesState>(
          builder: (context, provider, child) {
            switch (provider.pageState) {
              case TopArticlesStateEnum.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case TopArticlesStateEnum.error:
                return Center(
                  child: TryAgainButton(
                    text: 'Oh, looks like something went wrong!',
                    onTap: () => _fetchArticles(
                      updatePageState: provider.updatePageState,
                    ),
                  ),
                );
              case TopArticlesStateEnum.empty:
                return Center(
                  child: TryAgainButton(
                    text: 'No data available',
                    onTap: () => _fetchArticles(
                      updatePageState: provider.updatePageState,
                    ),
                  ),
                );
              case TopArticlesStateEnum.loaded:
                return TopArticlesLoaded(
                  valueStream: widget.topArticlesState.stream$,
                  onTap: _navigateToArticleDetails,
                );
            }
          },
        ),
      );

  void _startBackgroundFetch() =>
      widget.startBackgroundFetch(widget.topArticlesState.updateArticles);

  Future<void> _fetchArticles({
    required void Function(TopArticlesStateEnum) updatePageState,
  }) async {
    final result = await widget.getHeadlinesGroupedBySource();
    await widget.getFavoriteArticles();

    if (result.isRight) {
      widget.topArticlesState.updateArticles(result.right);
      updatePageState(TopArticlesStateEnum.loaded);
    } else {
      switch (result.left) {
        case GetTopHeadlinesEmptyListFailure():
          updatePageState(TopArticlesStateEnum.empty);
          break;
        case GetTopHeadlinesCatchFailure():
          updatePageState(TopArticlesStateEnum.error);
          break;
        default:
          updatePageState(TopArticlesStateEnum.error);
          break;
      }
    }
  }

  Future<void> _navigateToFavorites() async {
    await Navigator.pushNamed(
      context,
      TopArticleRoutes.favoriteArticles,
    );
  }

  Future<void> _navigateToArticleDetails(ArticleEntity articleEntity) async {
    await Navigator.pushNamed(
      context,
      TopArticleRoutes.articlesDetails,
      arguments: articleEntity,
    );
  }
}
