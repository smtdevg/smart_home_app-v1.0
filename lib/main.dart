import 'package:app_smart_home/provider/getit.dart';
import 'package:app_smart_home/provider/server.dart';
import 'package:app_smart_home/routes/routes.dart';
import 'package:app_smart_home/service/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_smart_home/view/home_view/home.dart';

void main() async {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final ThemeMode themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ServerAddressProvider()),
      ],
      child: MaterialApp(
        title: 'My Home',
        navigatorKey: getIt<NavigationService>().navigatorKey,
        debugShowCheckedModeBanner: false,
        themeMode: themeMode,
        theme: ThemeData(
          fontFamily: 'Poppins',
          textSelectionTheme: const TextSelectionThemeData(
            // Set Up for TextFields
            cursorColor: Colors.grey,
            selectionColor: Colors.blueGrey,
          ),
          colorScheme: const ColorScheme.light(
            primary: Color(0xFFF2F2F2),
            surface: Color(0xFFC4C4C4),
            error: Color(0xFFB00020),
            onPrimary: Colors.white,
            onSurface: Colors.black,
            onError: Colors.white,
            brightness: Brightness.light,
          ),
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
              fontSize: 32,
              color: Color(0xFF464646),
            ),
            displayMedium: TextStyle(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Color(0xFF464646),
            ),
            displaySmall: TextStyle(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
              fontSize: 18,
              color: Color(0xFF464646),
            ),
            headlineLarge: TextStyle(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
              fontSize: 18,
              color: Color(0xFFBDBDBD),
            ),
            headlineMedium: TextStyle(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: Color(0xFFBDBDBD),
            ),
            headlineSmall: TextStyle(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Color(0xFF464646),
            ),
          ),
        ),
        routes: routes,
        home: const HomePage(),
      ),
    );
  }
}
