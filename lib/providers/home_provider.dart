import 'package:flutter/material.dart';
import 'package:top_news/controller/home_controller.dart';
import 'package:top_news/model/news_response_model.dart';

class HomeProvider extends ChangeNotifier {
  final HomeController _homeController = HomeController();

  Future<NewsResponseModel?> fetchNews(String author) async {
    return await _homeController.fetchNews(author);
  }
}
