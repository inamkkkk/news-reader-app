import 'package:flutter/material.dart';
import 'package:news_reader/screens/news_list_screen.dart';
import 'package:provider/provider.dart';
import 'package:news_reader/services/news_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(    
      create: (context) => NewsService(),
      child: MaterialApp(
        title: 'News Reader',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: NewsListScreen(),
      ),
    );
  }
}