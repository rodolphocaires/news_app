import 'package:flutter/material.dart';
import 'package:news_app/features/shared/shared.dart';

class CardInfo extends StatelessWidget {
  const CardInfo({
    super.key,
    required this.sourceName,
    required this.author,
    required this.imageUrl,
    required this.titleNews,
    required this.onTap,
  });

  final String sourceName;
  final String author;
  final String imageUrl;
  final String titleNews;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xFF383838),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: ImageNetwork(
                    imageUrl: imageUrl,
                    defaultIconColor: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text(
                          _getSource(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      if (titleNews.isNotEmpty)
                        Text(
                          titleNews,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 14,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 12),
                child: Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      );

  String _getSource() {
    String result = sourceName.isNotEmpty ? sourceName : 'Source not available';
    if (author.isNotEmpty) {
      result += ' - $author';
    }
    return result;
  }
}
