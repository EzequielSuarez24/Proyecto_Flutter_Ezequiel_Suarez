import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:Proyecto_Flutter_Ezequiel_Suarez/widgets/drawer_menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 250, 239, 141), // Color sobrio para el AppBar
        title: const Text(
          'Proyecto Ezequiel Suarez',
          style: TextStyle(
            fontFamily: 'time new roman', // Fuente profesional
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
        width: double.infinity, // Ocupa todo el ancho
        height: double.infinity, // Ocupa toda la altura
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fondo.png'), // Ruta de la imagen de fondo
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0), // Espaciado interno del marco
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8), // Fondo claro con transparencia
              borderRadius: BorderRadius.circular(15), // Bordes redondeados
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26, // Sombra tenue
                  blurRadius: 10, // Desenfoque de la sombra
                  offset: Offset(4, 4), // Desplazamiento de la sombra
                ),
              ],
            ),
            child: const Text(
              '¡Bienvenido a Spotify App!',
              style: TextStyle(
                fontFamily: 'RobotoSlab', // Fuente profesional
                fontSize: 24, // Tamaño del texto
                fontWeight: FontWeight.bold, // Texto en negrita
                color: Colors.black, // Color del texto (oscuro para contraste)
              ),
              textAlign: TextAlign.center, // Centrado del texto
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black, // Color sobrio para el botón
        child: const Icon(
          Icons.add,
          color: Colors.white, // Ícono contrastante
        ),
        onPressed: () {
          log('click button');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
