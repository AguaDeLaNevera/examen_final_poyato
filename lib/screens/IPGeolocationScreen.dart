import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class IPGeolocationScreen extends StatefulWidget {
  @override
  _IPGeolocationScreenState createState() => _IPGeolocationScreenState();
}

class _IPGeolocationScreenState extends State<IPGeolocationScreen> {
  // Definició de la variable que contindrà la informació de geolocalització
  late Future<Map<String, dynamic>> ipGeolocation;

  @override
  void initState() {
    super.initState();
    // Inicialització de la consulta a la API per obtenir la geolocalització de la IP
    ipGeolocation = fetchIPGeolocation();
  }

  // Funció asíncrona per obtenir la geolocalització de la IP mitjançant crides HTTP
  Future<Map<String, dynamic>> fetchIPGeolocation() async {
    // Obtenció de la IP pública mitjançant una crida a la primera API
    final response =
        await http.get(Uri.parse('https://api.ipify.org/?format=json'));
    final ipData = json.decode(response.body);

    // Obtenció de la informació detallada de geolocalització utilitzant la IP
    final geoResponse =
        await http.get(Uri.parse('https://ipinfo.io/${ipData['ip']}/geo'));
    final geoData = json.decode(geoResponse.body);

    // Retorn de les dades necessàries en un mapa
    return {
      'ip': ipData['ip'],
      'city': geoData['city'],
      'region': geoData['region'],
      'country': geoData['country'],
      'loc': geoData['loc'],
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IP Geolocalització'),
      ),
      body: FutureBuilder(
        future: ipGeolocation,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Mostra un indicador de càrrega mentre es carreguen les dades
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // Mostra un missatge d'error si hi ha hagut algun problema
            return Text('Error: ${snapshot.error}');
          } else {
            // Obtinguda la geolocalització, mostrem les dades i el mapa
            final geolocationData = snapshot.data as Map<String, dynamic>;
            final coordinates = geolocationData['loc'].split(',');

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Adreça IP Pública: ${geolocationData['ip']}'),
                Text('Ciutat: ${geolocationData['city']}'),
                Text('Regió: ${geolocationData['region']}'),
                Text('País: ${geolocationData['country']}'),
                SizedBox(height: 20),
                Container(
                  height: 300,
                  width: double.infinity,
                  child: GoogleMap(
                    // Configuració del mapa amb les coordenades obtingudes
                    initialCameraPosition: CameraPosition(
                      target: LatLng(double.parse(coordinates[0]),
                          double.parse(coordinates[1])),
                      zoom: 10,
                    ),
                    markers: {
                      Marker(
                        markerId: MarkerId('currentLocation'),
                        position: LatLng(double.parse(coordinates[0]),
                            double.parse(coordinates[1])),
                        infoWindow: InfoWindow(title: 'La Teva Ubicació'),
                      ),
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
