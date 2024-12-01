import 'package:flutter/material.dart';
import 'package:Proyecto_Flutter_Ezequiel_Suarez/helpers/preferences.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Profile Screen'),
        elevation: 10,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderProfile(size: size),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: BodyProfile(),
            ),
          ],
        ),
      ),
    );
  }
}

class BodyProfile extends StatelessWidget {
  const BodyProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        const Text(
          'Ezequiel Suarez',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Text(
          'Fecha de Nacimiento: 22/04/1997',
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 10),
        const Text(
          'Teléfono: +54 291 641 6074',
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 20),
        const Divider(),
        SwitchListTile.adaptive(
          title: const Text('Modo oscuro'),
          value: Preferences.darkmode,
          onChanged: (bool value) {
            Preferences.darkmode = value;
            MyApp.of(context).updateTheme(value ? ThemeMode.dark : ThemeMode.light);
          },
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

class HeaderProfile extends StatelessWidget {
  const HeaderProfile({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: size.height * 0.40,
      color: Theme.of(context).primaryColor,
      child: Center(
        child: CircleAvatar(
          radius: 80,
          backgroundImage: AssetImage('assets/images/perfil.jpg'),
        ),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void updateTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: const ProfileScreen(),
    );
  }
}
