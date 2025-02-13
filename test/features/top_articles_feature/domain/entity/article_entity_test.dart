import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/features/top_articles_feature/top_articles_feature.dart';

void main() {
  group('ArticleEntity', () {
    const entity = ArticleEntity(
      author: 'author',
      title: 'title',
      description: 'description',
      url: 'url',
      urlToImage: 'urlToImage',
      publishedAt: 'publishedAt',
      content: 'content',
    );

    test('Should return the correct values from the entity', () {
      expect(entity, isA<ArticleEntity>());
      expect(entity.author, 'author');
      expect(entity.title, 'title');
      expect(entity.description, 'description');
      expect(entity.url, 'url');
      expect(entity.urlToImage, 'urlToImage');
      expect(entity.publishedAt, 'publishedAt');
      expect(entity.content, 'content');
    });

    test('Should replace values updated by copyWith', () {
      final updatedEntity = entity.copyWith(
        author: 'author2',
        title: 'title2',
        description: 'description2',
        url: 'url2',
        urlToImage: 'urlToImage2',
        publishedAt: 'publishedAt2',
        content: 'content2',
      );
      expect(updatedEntity.author, 'author2');
      expect(updatedEntity.title, 'title2');
      expect(updatedEntity.description, 'description2');
      expect(updatedEntity.url, 'url2');
      expect(updatedEntity.urlToImage, 'urlToImage2');
      expect(updatedEntity.publishedAt, 'publishedAt2');
      expect(updatedEntity.content, 'content2');
    });
  });
}
