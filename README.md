# News Reader App

A simple news reader application built with Flutter.

## Features

*   Fetches news articles from a news API.
*   Displays a list of news headlines.
*   Allows users to read the full article in an in-app web browser.

## Technologies Used

*   Flutter
*   Dart
*   Provider (State Management)
*   http (Network Requests)
*   webview_flutter (In-App Browser)

## API Used

You need to obtain an API key from a news API provider (e.g., News API, Guardian Open Platform) and replace `YOUR_API_KEY` in `lib/services/news_service.dart` with your actual API key.

## Getting Started

1.  Clone the repository.
2.  Run `flutter pub get` to install dependencies.
3.  Replace `YOUR_API_KEY` in `lib/services/news_service.dart` with your actual API key.
4.  Run `flutter run` to launch the application.

## Folder Structure


lib/
  main.dart           # Entry point of the application
  screens/
    news_list_screen.dart # Displays the list of news articles
    article_screen.dart   # Displays the full article in a web view
  models/
    article.dart        # Data model for news articles
  services/
    news_service.dart   # Handles fetching news articles from the API

