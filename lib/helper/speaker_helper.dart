import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeakerHelper {
  final ValueNotifier<String> lastStatusNotifier = ValueNotifier('');
  late FlutterTts flutterTts;
  String? language;
  String? engine;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;
  bool isCurrentLanguageInstalled = false;
  SpeechToText speechToText = SpeechToText();
  bool speechEnabled = false;
  final String _newVoiceText =
      "lütfen aramak istediğiniz haber sitesini söyleyin";
  final ValueNotifier<String> lastWords = ValueNotifier('');
  String _lastStatus = '';

  void initSpeech() async {
    speechEnabled = await speechToText.initialize(onStatus: statusListener);
    //setState(() {});
  }

  void statusListener(String status) {
    //setState(() {
    _lastStatus = status;
    //print(_lastStatus);
    lastStatusNotifier.value = status;
    //if (_lastStatus == "notListening") {

    /*context.read<HomeProvider>().fetchNews(_lastWords).then((value) {
        if (value != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewsReaderView(news: value)));
        } else {
          print("something went wrong!");
        }
      });*/
    //}
    //});
  }

  Future speak(String textToRead) async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.speak(textToRead);
  }

  void startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    //setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    //setState(() {
    lastWords.value = result.recognizedWords;
    //});
  }

  initTts(bool isListeningActive) {
    flutterTts = FlutterTts();

    getDefaultEngine();

    flutterTts.setStartHandler(() {
      //setState(() {
      // ignore: avoid_print
      print("Playing");
      //});
    });

    flutterTts.setCompletionHandler(() {
      //setState(() {
      print("Complete");
      isListeningActive ? startListening() : null;
      //});
    });

    flutterTts.setCancelHandler(() {
      //setState(() {
      print("Cancel");
      //});
    });

    flutterTts.setErrorHandler((msg) {
      //setState(() {
      print("error: $msg");
      //});
    });
  }

  Future getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
  }
}
