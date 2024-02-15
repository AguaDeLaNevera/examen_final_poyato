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
  late Future<Map<String, dynamic>> ipGeolocation;

  @override
  void initState() {
    super.initState();
    ipGeolocation = fetchIPGeolocation();
  }

  Future<Map<String, dynamic>> fetchIPGeolocation() async {
    final response =
        await http.get(Uri.parse('https://api.ipify.org/?format=json'));
    final ipData = json.decode(response.body);

    final geoResponse =
        await http.get(Uri.parse('https://ipinfo.io/${ipData['ip']}/geo'));
    final geoData = json.decode(geoResponse.body);

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
        title: Text('IP Geolocation'),
      ),
      body: FutureBuilder(
        future: ipGeolocation,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final geolocationData = snapshot.data as Map<String, dynamic>;
            final coordinates = geolocationData['loc'].split(',');

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Public IP Address: ${geolocationData['ip']}'),
                Text('City: ${geolocationData['city']}'),
                Text('Region: ${geolocationData['region']}'),
                Text('Country: ${geolocationData['country']}'),
                SizedBox(height: 20),
                Container(
                  height: 300,
                  width: double.infinity,
                  child: GoogleMap(
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
                        infoWindow: InfoWindow(title: 'Your Location'),
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
