import 'package:cueprise/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dark_theme.dart';
import 'form_provider.dart';
import 'light_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppFieldState createState() => _MyAppFieldState();
}

class _MyAppFieldState extends State<MyApp> with WidgetsBindingObserver {

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    print("======================");
    super.didChangePlatformBrightness();
    var brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    MyApp.themeNotifier.value = brightness == Brightness.light ? ThemeMode.light : ThemeMode.dark;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: MyApp.themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Cueprise',
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: currentMode,
              home: ChangeNotifierProvider(
                  create: (_) => FormProvider(),
                  child: const SignUpScreen(),
              ));
        });
  }
}
