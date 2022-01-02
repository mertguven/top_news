import 'package:top_news/model/news_response_model.dart';
import 'package:top_news/service/network_service.dart';

class HomeController {
  final NetworkService _networkService = NetworkService();

  Future<NewsResponseModel?> fetchNews(String author) async {
    final response = await _networkService.fetchNews(author);
    if (response != null) {
      final model = NewsResponseModel.fromJson(response);
      return model;
    } else {
      return null;
    }
  }
}
