import 'package:flutter/material.dart';
import 'package:news_reader/models/article.dart';
import 'package:news_reader/screens/article_screen.dart';
import 'package:news_reader/services/news_service.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class NewsListScreen extends StatefulWidget {
  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<NewsService>(context, listen: false).fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Reader'),
      ),
      body: Consumer<NewsService>(
        builder: (context, newsService, child) {
          if (newsService.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (newsService.articles.isEmpty) {
            return const Center(
              child: Text('No news available.'),
            );
          } else {
            return ListView.builder(
              itemCount: newsService.articles.length,
              itemBuilder: (context, index) {
                final article = newsService.articles[index];
                return NewsCard(article: article);
              },
            );
          }
        },
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  const NewsCard({Key? key, required this.article}) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleScreen(url: article.url),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (article.urlToImage != null)
                Image.network(
                  article.urlToImage!,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox( // Placeholder in case of image loading error
                      height: 200,
                      child: Center(child: Icon(Icons.error)),
                    );
                  },
                ),
              Text(
                article.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                article.description ?? 'No description available.',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Source: ${article.source.name}'),
                  Text(
                    DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.parse(article.publishedAt)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}