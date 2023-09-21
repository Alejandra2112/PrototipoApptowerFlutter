import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

const Token =
    'pk.eyJ1IjoicGl0bWFjIiwiYSI6ImNsY3BpeWxuczJhOTEzbnBlaW5vcnNwNzMifQ.ncTzM4bW-jpq-hUFutnR1g';

class MapaUbicacionView extends StatefulWidget {
  const MapaUbicacionView({Key? key}) : super(key: key);

  @override
  State<MapaUbicacionView> createState() => _MapaUbicacionViewState();
}

class _MapaUbicacionViewState extends State<MapaUbicacionView> {
  LatLng? miUbicacion;
  double currentZoom = 18.0;
  double minZoom = 5.0;
  double maxZoom = 25.0;

  Future<Position> determinePosition() async {
    LocationPermission autorizacion;
    autorizacion = await Geolocator.checkPermission();
    if (autorizacion == LocationPermission.denied) {
      autorizacion = await Geolocator.requestPermission();
      if (autorizacion == LocationPermission.denied) {
        return Future.error('error');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  void getCurrentLocation() async {
    Position position = await determinePosition();
    setState(() {
      miUbicacion = LatLng(position.latitude, position.longitude);
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
        title: Text('Ubicación'),
        backgroundColor: Color.fromARGB(255, 11, 0, 61),
      ),
      body: Column(
        children: [
          Expanded(
            child: miUbicacion == null
                ? Center(child: CircularProgressIndicator())
                : FlutterMap(
                    options: MapOptions(
                      center: miUbicacion!,
                      minZoom: minZoom,
                      maxZoom: maxZoom,
                      zoom: currentZoom,
                    ),
                    nonRotatedChildren: [
                      TileLayer(
                        urlTemplate:
                            'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                        additionalOptions: {
                          'accessToken': Token,
                          'id': 'mapbox/streets-v12',
                        },
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: miUbicacion!,
                            builder: (context) {
                              return Container(
                                child: Icon(
                                  Icons.person_pin,
                                  color: Colors.blueAccent,
                                  size: 40,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 11, 0, 61),
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            
          ),
        ),
      ),
     
    );
  }
}
