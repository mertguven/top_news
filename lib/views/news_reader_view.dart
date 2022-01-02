import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:top_news/helper/speaker_helper.dart';
import 'package:top_news/model/news_response_model.dart';

class NewsReaderView extends StatefulWidget {
  final NewsResponseModel news;
  final String author;
  const NewsReaderView({Key? key, required this.news, required this.author})
      : super(key: key);

  @override
  _NewsReaderViewState createState() => _NewsReaderViewState();
}

class _NewsReaderViewState extends State<NewsReaderView> {
  late SpeakerHelper _speakerHelper;

  @override
  void initState() {
    super.initState();
    _speakerHelper = SpeakerHelper();
    _speakerHelper.initTts(false);
    newsSpeaker();
  }

  Future<void> newsSpeaker() async {
    for (var item in widget.news.articles ?? <Articles>[]) {
      await _speakerHelper.speak(item.title ?? "Title");
      await _speakerHelper.speak(item.description ?? "Description");
      await _speakerHelper.speak("yeni haber");
    }
  }

  @override
  void dispose() {
    super.dispose();
    _speakerHelper.flutterTts.stop();
    _speakerHelper.speechToText.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.author),
        centerTitle: true,
        actions: [LottieBuilder.asset("assets/animations/soundwave.json")],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: widget.news.articles?.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: const [BoxShadow()],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.news.articles?[index].author ?? "Author",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Divider(),
                  Text(
                    widget.news.articles?[index].title ?? "Title",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  Divider(),
                  Text(
                    widget.news.articles?[index].description ?? "Description",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
