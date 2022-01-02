import 'package:dio/dio.dart';
import 'package:top_news/core/app_constants.dart';

class NetworkService {
  final Dio _dio = Dio(BaseOptions(baseUrl: AppConstants.apiBaseUrl));

  Future<dynamic> fetchNews(String author) async {
    try {
      final authorTurkishVersion =
          turkishCharacterToEnglishCharecter(author.toLowerCase());
      final response = await _dio.get(
          "&domains=${authorTurkishVersion.toLowerCase()}.com${authorTurkishVersion.toLowerCase() == "sozcu" ? ".tr" : ""}");
      return response.data;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  String turkishCharacterToEnglishCharecter(String author) {
    final turkishCharacters = [
      'ı',
      'ğ',
      'İ',
      'Ğ',
      'ç',
      'Ç',
      'ş',
      'Ş',
      'ö',
      'Ö',
      'ü',
      'Ü'
    ];
    final englishCharacters = [
      'i',
      'g',
      'I',
      'G',
      'c',
      'C',
      's',
      'S',
      'o',
      'O',
      'u',
      'U'
    ];

    // Match chars
    for (int i = 0; i < turkishCharacters.length; i++)
      author = author.replaceAll(turkishCharacters[i], englishCharacters[i]);

    return author;
  }
}
