import 'package:adminhala/Page/AuthPages/SingUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

/// ignore: constant_identifier_names
const MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1IjoiYWRoYW0wNTY4IiwiYSI6ImNsanpuM3I3ODBrYXkzaG56Ymdhc2Z1MDMifQ.q0SCdN6iwR17f5JrUjL_ew';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  LatLng? myPosition;

  Future<Position> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('error');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  void getCurrentLocation() async {
    Position position = await determinePosition();
    setState(() {
      myPosition = LatLng(position.latitude, position.longitude);
      print(myPosition);
    });
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Mapa'),
        backgroundColor: Colors.blueAccent,
      ),
      body: myPosition == null
          ? const CircularProgressIndicator()
          : Stack(
            children: [
              FlutterMap(
        options: MapOptions(
                center: myPosition, minZoom: 5, maxZoom: 25, zoom: 18),
        nonRotatedChildren: [
              TileLayer(
                urlTemplate:
                'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                additionalOptions: const {
                  'accessToken': MAPBOX_ACCESS_TOKEN,
                  'id': 'adham0568/clk87oepj00l001pfbpumgu7y'
                },
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: myPosition!,
                    builder: (context) {
                      return Container(
                        child: const Icon(
                          Icons.person_pin,
                          color: Colors.blueAccent,
                          size: 40,
                        ),
                      );
                    },
                  )
                ],
              )
        ],
      ),
              ElevatedButton(onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                  SingUpPage(Lat: myPosition!.latitude, Long: myPosition!.longitude,LocationAdd: true),));},
                  child: const Text('التالي'))
            ],
          ),
    );
  }
}
