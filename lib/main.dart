import 'package:cueprise/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dark_theme.dart';
import 'form_provider.dart';
import 'light_theme.dart';

SharedPreferences? prefs;

void main() async {
      WidgetsFlutterBinding.ensureInitialized();
      prefs = await SharedPreferences.getInstance();
      runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static late ValueNotifier<ThemeMode> themeNotifier;

  const MyApp({Key? key}) : super(key: key);


  @override
  _MyAppFieldState createState() => _MyAppFieldState();
}

class _MyAppFieldState extends State<MyApp> with WidgetsBindingObserver {


  @override
  void initState() {
    var saved =  prefs?.getBool('isDark') ?? false;
    MyApp.themeNotifier = ValueNotifier(
        saved ? ThemeMode.dark : ThemeMode.light
    );
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    super.didChangePlatformBrightness();
    var brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    if (brightness == Brightness.light) {
      MyApp.themeNotifier.value = ThemeMode.light;
      prefs.setBool('isDark', false);
    } else {
      MyApp.themeNotifier.value = ThemeMode.dark;
      prefs.setBool('isDark', true);
    }
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
