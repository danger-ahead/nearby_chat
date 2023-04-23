import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nearby_chat/locator.dart';
import 'package:nearby_chat/nearbychat_theme.dart';
import 'package:nearby_chat/ui/base_view.dart';
import 'package:nearby_chat/ui/screens/home.dart';
import 'package:nearby_chat/viewmodels/main_viewmodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();

  runApp(const NearbyChatApp());
}

class NearbyChatApp extends StatefulWidget {
  const NearbyChatApp({Key? key}) : super(key: key);

  @override
  State<NearbyChatApp> createState() => _NearbyChatAppState();
}

class _NearbyChatAppState extends State<NearbyChatApp> {
  late MainViewModel _model;

  @override
  Widget build(BuildContext context) {
    return BaseView<MainViewModel>(
        onModelReady: (model) => {_model = model, _model.initState()},
        builder: ((context, model, child) => GetMaterialApp(
              title: 'Nearby Chat',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                brightness: Brightness.light,
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: NearbyChatTheme.primaryColorDark,
                  ),
                ),
                progressIndicatorTheme: const ProgressIndicatorThemeData(
                  color: NearbyChatTheme.primaryColorDark,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: NearbyChatTheme.primaryColorDark,
                  ),
                ),
                textSelectionTheme: const TextSelectionThemeData(
                  cursorColor: NearbyChatTheme.primaryColor,
                ),
                appBarTheme: AppBarTheme(
                  foregroundColor: NearbyChatTheme.drawerIcon(context),
                ),
                colorScheme: Theme.of(context).colorScheme.copyWith(
                      primary: NearbyChatTheme.primaryColor,
                      brightness: Brightness.light,
                    ),
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                textSelectionTheme: const TextSelectionThemeData(
                  cursorColor: NearbyChatTheme.primaryColor,
                ),
              ),
              themeMode: _model.theme == 'light'
                  ? ThemeMode.light
                  : _model.theme == 'dark'
                      ? ThemeMode.dark
                      : ThemeMode.system,
              home: const Home(),
            )));
  }
}
