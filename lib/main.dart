import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:github_app/screens/splash_screen.dart';
import 'package:github_app/utils/colors_constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: kColorPrimary,
    statusBarIconBrightness: Brightness.light,
  ));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "NotoSans",
        primarySwatch: kColorPrimary,
      ),
      home: SplashScreen(),
    );
  }
}
