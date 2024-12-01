//main.dart

Este archivo contiene el punto de entrada de la aplicación. Configura las preferencias iniciales y establece la estructura básica de rutas y tema:
void main(): Inicializa las preferencias compartidas (almacenamiento persistente) y ejecuta la aplicación.
Clase MyApp: Configura el tema de la aplicación (modo claro u oscuro) y define las rutas para la navegación entre pantallas (home, spotify, profile).

//home_screen.dart
Esta pantalla representa la página principal de la aplicación con un diseño atractivo:
Barra superior (AppBar): Tiene un título centrado, un diseño profesional y un botón de menú lateral (drawer).
Cuerpo (Body): Fondo personalizado con una imagen y un mensaje de bienvenida estilizado en un contenedor centrado.
Botón flotante (FAB): Un botón con ícono para futuras interacciones, actualmente registra un mensaje en la consola.

//profile_screen.dart
Esta pantalla muestra un perfil personal y permite alternar entre modo claro y oscuro:
Encabezado del perfil: Una imagen circular grande representa al usuario.
Cuerpo: Contiene información personal (nombre, fecha de nacimiento, teléfono) y un interruptor para cambiar el tema (modo claro/oscuro).
Clase MyApp extendida: Maneja el estado del tema y lo actualiza en tiempo real.

//spotify_screen.dart
Esta pantalla conecta con la API de Spotify para mostrar los lanzamientos recientes y permite filtrarlos:
Autenticación con Spotify: Obtiene un token de acceso para interactuar con la API.
Consulta de datos: Obtiene una lista de lanzamientos recientes, incluyendo información como nombre, artista, fecha, y más.
Filtros: Permite buscar canciones por ID, nombre, y limitar la cantidad de resultados mostrados.
Interacción con enlaces: Abre la URL de Spotify del álbum o canción en el navegador predeterminado.

//Diseño general de la aplicación
La aplicación sigue el modelo de navegación por rutas, con temas dinámicos y un diseño adaptativo:
Rutas definidas: home, spotify, profile.
Compatibilidad con temas: Alterna entre modo oscuro y claro.
API de Spotify: Permite explorar contenido musical y personalizar la experiencia mediante filtros.

//Cómo iniciar la aplicación
Clonar o descargar el repositorio.
Instalar las dependencias: bash

//Copiar código
flutter pub get

//Ejecutar la aplicación:
bash
Copiar código
flutter run
Navegar entre las pantallas para explorar las funcionalidades (home, spotify, profile).