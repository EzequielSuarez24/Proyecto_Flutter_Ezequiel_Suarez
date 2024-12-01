import 'package:flutter/material.dart';
import 'package:Proyecto_Flutter_Ezequiel_Suarez/helpers/preferences.dart';
import 'package:Proyecto_Flutter_Ezequiel_Suarez/screens/screens.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.initShared();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'home', // Ruta inicial
        theme: Preferences.darkmode ? ThemeData.dark() : ThemeData.light(),
        routes: {
          'home': (context) => const HomeScreen(),
          'spotify': (context) => const ScreenSpotify(), 
          'profile': (context) => const ProfileScreen(),
        }
        /* home: DesignScreen(), */
        );
  }
}
