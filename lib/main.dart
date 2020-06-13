import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'fluro_router.dart';
import 'package:device_preview/device_preview.dart';

import 'package:responsive_framework/responsive_framework.dart';

import 'providers/dark_theme_provider.dart';
import 'providers/editor_image_provider.dart';
import 'constants/theme_data.dart';
import 'providers/post_provider.dart';
import 'constants/app_theme.dart';

void main() {
  FluroRouter.setupRouter();

  runApp(DevicePreview(
    enabled: false,
    // enabled: !kReleaseMode,
    builder: (context) => MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => themeChangeProvider,
        ),
        ChangeNotifierProvider(
          create: (context) => Images(),
        )
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, value, child) {
          return MaterialApp(
              locale: DevicePreview.of(context).locale,
              //builder: DevicePreview.appBuilder,
              builder: (context, widget) => ResponsiveWrapper.builder(
                    BouncingScrollWrapper.builder(context, widget),
                    // maxWidth: 1200,
                    // minWidth: 450,
                    defaultScale: true,
                    breakpoints: [
                      ResponsiveBreakpoint.resize(450, name: MOBILE),
                      ResponsiveBreakpoint.autoScale(800, name: TABLET),
                      ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                      ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                      ResponsiveBreakpoint.autoScale(2460, name: "4K"),
                    ],
                  ),
              title: 'Flutter Demo',
              theme: Styles.themeData(themeChangeProvider.darkTheme, context),

              // theme: ThemeData.dark(),
              initialRoute: '',
              onGenerateRoute: FluroRouter.router.generator);
        },
      ),
    );
  }
}
