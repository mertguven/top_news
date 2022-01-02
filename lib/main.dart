import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_news/providers/home_provider.dart';
import 'package:top_news/views/home_view.dart';

import 'core/config/app_config.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConfig.appName,
      theme: AppConfig.theme,
      home: MultiProvider(
        providers: [
          Provider<HomeProvider>(create: (_) => HomeProvider()),
        ],
        child: HomeView(),
      ),
    );
  }
}
