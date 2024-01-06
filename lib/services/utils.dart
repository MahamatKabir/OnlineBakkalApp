import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';

class Utils {
  BuildContext context;
  Utils(this.context);

  bool get getTheme => Provider.of<DarkThemeProvider>(context).getDarkTheme;
  Color get color => getTheme ? Color.fromARGB(255, 0, 0, 0) : Colors.black;
  Size get getScreenSize => MediaQuery.of(context).size;
}
