import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'fluro_router.dart';

import 'providers/post_provider.dart';
import 'constants/app_theme.dart';

void main() {
  FluroRouter.setupRouter();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Posts(),
      child: MaterialApp(
          title: 'Flutter Demo',
          //theme: ThemeData.dark(),
          theme: themeDataDark,
          //theme: AppTheme.darkTheme,

          // theme: ThemeData(
          //   primarySwatch: Colors.blue,
          //   visualDensity: VisualDensity.adaptivePlatformDensity,
          // ),
          //home: MyHomePage(title: 'Flutter Demo Home Page'),
          initialRoute: '',
          onGenerateRoute: FluroRouter.router.generator),
    );
  }
}
