import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/features/top_articles_feature/top_articles_feature.dart';

void main() {
  group('fromEntity', () {
    test('should return model when an entity is passed as param', () async {
      const entity = ArticleEntity(
        sourceId: 'id',
        sourceName: 'name',
        author: 'author',
        title: 'title',
        description: 'description',
        url: 'url',
        urlToImage: 'urlToImage',
        publishedAt: 'publishedAt',
        content: 'content',
      );
      final model = ArticleModel.fromEntity(entity);
      expect(model.sourceId, 'id');
      expect(model.sourceName, 'name');
      expect(model.author, 'author');
      expect(model.title, 'title');
      expect(model.description, 'description');
      expect(model.url, 'url');
      expect(model.urlToImage, 'urlToImage');
      expect(model.publishedAt, 'publishedAt');
      expect(model.content, 'content');
    });
  });

  group('fromJson', () {
    test('should return model when params are present in map', () async {
      const map = {
        'source': {
          'id': 'id',
          'name': 'name',
        },
        'author': 'author',
        'title': 'title',
        'description': 'description',
        'url': 'url',
        'urlToImage': 'urlToImage',
        'publishedAt': 'publishedAt',
        'content': 'content',
      };
      final model = ArticleModel.fromMap(map);
      expect(model.sourceId, 'id');
      expect(model.sourceName, 'name');
      expect(model.author, 'author');
      expect(model.title, 'title');
      expect(model.description, 'description');
      expect(model.url, 'url');
      expect(model.urlToImage, 'urlToImage');
      expect(model.publishedAt, 'publishedAt');
      expect(model.content, 'content');
    });

    test('should return model with default value when params are not present in map', () async {
      final model = ArticleModel.fromMap(const {});
      expect(model.sourceId, '');
      expect(model.sourceName, '');
      expect(model.author, '');
      expect(model.title, '');
      expect(model.description, '');
      expect(model.url, '');
      expect(model.urlToImage, '');
      expect(model.publishedAt, '');
      expect(model.content, '');
    });
  });

  group('toMap', () {
    test('should return map with model values', () async {
      const model = ArticleModel(
        sourceId: 'id',
        sourceName: 'name',
        author: 'author',
        title: 'title',
        description: 'description',
        url: 'url',
        urlToImage: 'urlToImage',
        publishedAt: 'publishedAt',
        content: 'content',
      );
      final map = model.toMap();
      expect(map['source']['id'], 'id');
      expect(map['source']['name'], 'name');
      expect(map['author'], 'author');
      expect(map['title'], 'title');
      expect(map['description'], 'description');
      expect(map['url'], 'url');
      expect(map['urlToImage'], 'urlToImage');
      expect(map['publishedAt'], 'publishedAt');
      expect(map['content'], 'content');
    });
  });
}
