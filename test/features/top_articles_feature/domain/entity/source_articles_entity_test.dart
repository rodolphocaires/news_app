import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/features/top_articles_feature/top_articles_feature.dart';

void main() {
  group('SourceArticlesEntity', () {
    const articleEntity = ArticleEntity(
      author: 'author',
      title: 'title',
      description: 'description',
      url: 'url',
      urlToImage: 'urlToImage',
      publishedAt: 'publishedAt',
      content: 'content',
    );
    const entity = SourceArticlesEntity(
      id: 'id',
      name: 'name',
      articles: [articleEntity],
    );

    test('Should return the correct values from the entity', () {
      expect(entity, isA<SourceArticlesEntity>());
      expect(entity.id, 'id');
      expect(entity.name, 'name');
      expect(entity.articles, [articleEntity]);
    });

    test('Should replace values updated by copyWith', () {
      final articleEntity2 = articleEntity.copyWith(
        author: 'author2',
        title: 'title2',
        description: 'description2',
        url: 'url2',
        urlToImage: 'urlToImage2',
        publishedAt: 'publishedAt2',
        content: 'content2',
      );

      final updatedEntity = entity.copyWith(
        id: 'id2',
        name: 'name2',
        articles: [articleEntity2],
      );
      expect(updatedEntity.id, 'id2');
      expect(updatedEntity.name, 'name2');
      expect(updatedEntity.articles, [articleEntity2]);
    });
  });
}
