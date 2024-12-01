import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ScreenSpotify extends StatefulWidget {
  const ScreenSpotify({Key? key}) : super(key: key);

  @override
  _ScreenSpotifyState createState() => _ScreenSpotifyState();
}

class _ScreenSpotifyState extends State<ScreenSpotify> {
  final String clientId = '289511584bc3438d9b7d65ecda9179bb';
  final String clientSecret = '307a2b7661a14bd5ab43a6d2d881cddd';
  String? accessToken;
  List<dynamic> allTracks = [];
  List<dynamic> filteredTracks = [];
  String errorMessage = '';
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  int itemsToShow = 50;

  @override
  void initState() {
    super.initState();
    _fetchAccessToken();
  }

  Future<void> _fetchAccessToken() async {
    try {
      final response = await http.post(
        Uri.parse('https://accounts.spotify.com/api/token'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Basic ${base64Encode(utf8.encode('$clientId:$clientSecret'))}',
        },
        body: {'grant_type': 'client_credentials'},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          accessToken = responseData['access_token'];
        });
        _fetchTracks();
      } else {
        setState(() {
          errorMessage = 'Error al obtener el token. Código: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error al obtener el token: $e';
      });
    }
  }

  Future<void> _fetchTracks() async {
    if (accessToken == null) return;

    try {
      final response = await http.get(
        Uri.parse('https://api.spotify.com/v1/browse/new-releases?limit=50'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final albums = data['albums']['items'];
        setState(() {
          allTracks = List.generate(albums.length, (index) {
            final album = albums[index];
            return {
              'id': index + 1,
              'name': album['name'],
              'artist': album['artists'][0]['name'],
              'release_date': album['release_date'],
              'total_tracks': album['total_tracks'],
              'image': album['images'][0]['url'],
              'url': album['external_urls']['spotify'],
            };
          });
          filteredTracks = allTracks; 
        });
      } else {
        setState(() {
          errorMessage = 'Error al cargar las canciones. Código: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error al obtener las canciones: $e';
      });
    }
  }

  // Filtra las canciones por ID, nombre y cantidad de canciones
  void _filterTracks() {
    setState(() {
      // Filtro por ID exacto
      filteredTracks = allTracks.where((track) {
        bool matchesId = idController.text.isEmpty
            ? true
            : track['id'].toString() == idController.text;
        bool matchesName = track['name'].toLowerCase().contains(nameController.text.toLowerCase());

        return matchesId && matchesName;
      }).toList();

      // Filtra por cantidad
      if (filteredTracks.length > itemsToShow) {
        filteredTracks = filteredTracks.sublist(0, itemsToShow);
      }
    });
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      setState(() {
        errorMessage = 'No se puede abrir la URL';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Las 50 mejores canciones de SPOTIFY',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: errorMessage.isNotEmpty
          ? Center(
              child: Text(
                errorMessage,
                style: const TextStyle(color: Colors.red, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      // Filtro por ID
                      TextField(
                        controller: idController,
                        decoration: const InputDecoration(
                          labelText: 'Buscar por ID',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) => _filterTracks(),
                      ),
                      const SizedBox(height: 10),

                      // Filtro por nombre
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: 'Buscar por nombre',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) => _filterTracks(),
                      ),
                      const SizedBox(height: 10),

                      // Filtro por cantidad de canciones
                      DropdownButton<int>(
                        value: itemsToShow,
                        onChanged: (newValue) {
                          setState(() {
                            itemsToShow = newValue!;
                            _filterTracks(); // Refiltra después de cambiar la cantidad
                          });
                        },
                        items: [10, 20, 30, 40, 50].map((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text('Mostrar $value canciones'),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: filteredTracks.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: filteredTracks.length,
                          itemBuilder: (context, index) {
                            final track = filteredTracks[index];
                            return Card(
                              color: Colors.grey[900],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: ListTile(
                                onTap: () => _launchURL(track['url']),
                                contentPadding: const EdgeInsets.all(8.0),
                                leading: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        track['image'],
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 5,
                                      right: 5,
                                      child: Icon(
                                        Icons.play_arrow,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                                title: Text(
                                  '${track['id']}. ${track['name']}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Artista: ${track['artist']}',
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.white70),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      'Lanzamiento: ${track['release_date']}',
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.white54),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      'Total Tracks: ${track['total_tracks']}',
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.white54),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}
