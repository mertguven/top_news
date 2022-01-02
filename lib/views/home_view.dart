import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/src/provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:top_news/helper/speaker_helper.dart';
import 'package:top_news/providers/home_provider.dart';
import 'package:top_news/views/news_reader_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late SpeakerHelper _speakerHelper;
  late FlutterTts flutterTts;
  final String _newVoiceText =
      "lütfen aramak istediğiniz haber sitesini söyleyin";

  @override
  initState() {
    super.initState();
    _speakerHelper = SpeakerHelper();
    _speakerHelper.initTts(true);
    _speakerHelper.initSpeech();
    _speakerHelper.speak(_newVoiceText);
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ValueListenableBuilder(
                valueListenable: _speakerHelper.lastWords,
                builder: (BuildContext context, value, Widget? child) {
                  print(_speakerHelper.lastWords.value);
                  return Text(
                    _speakerHelper.lastWords.value,
                    style: const TextStyle(fontSize: 24.0),
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  _speakerHelper.initTts(true);
                  _speakerHelper.speak(_newVoiceText);
                },
                style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(30)),
                child: const Icon(Icons.mic, size: 150),
              ),
              ValueListenableBuilder(
                valueListenable: _speakerHelper.lastStatusNotifier,
                builder: (context, value, child) {
                  if (_speakerHelper.lastStatusNotifier.value == "done") {
                    context
                        .read<HomeProvider>()
                        .fetchNews(_speakerHelper.lastWords.value)
                        .then((value) async {
                      if (value != null && value.totalResults! > 0) {
                        await _speakerHelper.flutterTts.stop();
                        await _speakerHelper.speechToText.stop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewsReaderView(
                                    news: value,
                                    author: _speakerHelper.lastWords.value)));
                      } else {
                        print("something went wrong!");
                      }
                    });
                  }
                  return Text(
                    value.toString() == ""
                        ? _newVoiceText + " veya mikrofon butonuna basın"
                        : value.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24.0),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
