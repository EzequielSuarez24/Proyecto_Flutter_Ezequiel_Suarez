import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:Proyecto_Flutter_Ezequiel_Suarez/widgets/drawer_menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 250, 239, 141), 
        title: const Text(
          'Proyecto Ezequiel Suarez',
          style: TextStyle(
            fontFamily: 'time new roman', 
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leadingWidth: 40,
        toolbarHeight: 80,
      ),
      drawer: DrawerMenu(),
      body: Container(
        width: double.infinity, 
        height: double.infinity, 
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fondo.png'), 
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0), 
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8), 
              borderRadius: BorderRadius.circular(15), 
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26, 
                  blurRadius: 10, 
                  offset: Offset(4, 4), 
                ),
              ],
            ),
            child: const Text(
              '¡Bienvenido a Spotify App!',
              style: TextStyle(
                fontFamily: 'RobotoSlab', 
                fontSize: 24,
                fontWeight: FontWeight.bold, 
                color: Colors.black, 
              ),
              textAlign: TextAlign.center, 
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black, 
        child: const Icon(
          Icons.add,
          color: Colors.white, 
        ),
        onPressed: () {
          log('click button');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
