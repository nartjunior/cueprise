import 'package:flutter/material.dart';

import 'main.dart';
import 'my_back_button.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leadingWidth: 100,
      backgroundColor: Theme.of(context).primaryColor,
      leading: const MyBackButton(),
      toolbarHeight: 80,
      centerTitle: true,
      title: const Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.ac_unit),
          SizedBox(width: 5), // give it width
          Text('cueprise')
        ],
      ),
      actions: [
        IconButton(
            icon: Icon(MyApp.themeNotifier.value == ThemeMode.light ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              var isDark = MyApp.themeNotifier.value == ThemeMode.dark;
              if (isDark) {
                MyApp.themeNotifier.value = ThemeMode.light;
                prefs?.setBool('isDark', false);
              } else {
                MyApp.themeNotifier.value = ThemeMode.dark;
                prefs?.setBool('isDark', true);
              }
            })
      ],
    );
  }


  @override
  Size get preferredSize => const Size.fromHeight(100);

}
