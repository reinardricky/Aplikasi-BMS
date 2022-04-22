import 'package:flutter/material.dart';
import 'package:mobileapp/Screens/settings.dart';
import 'package:mobileapp/Variables/custom_theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);

          return MaterialApp(
            title: 'Aplikasi Monitoring BMS',
            home: const SettingsScreen(),
            themeMode: themeProvider.themeMode,
            theme: CustomTheme.light(context),
            darkTheme: CustomTheme.dark(context),
            debugShowCheckedModeBanner: false,
          );
        },
      );
}
