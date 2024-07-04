import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';
import 'package:latlong2/latlong.dart';
import '../providers/currentweather_provider.dart';

class MyMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5.0,
            spreadRadius: 1.0,
            offset: Offset(0.0, 2.0),
          ),
        ],
      ),
      width: 320,
      height: 230,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Consumer<CityWeatherProvider>(
          builder: (context, myProvider, child) {
            if (myProvider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final currentWeather = myProvider.currentWeather;

            if (currentWeather == null ||
                currentWeather.coord == null ||
                currentWeather.coord?.lat == null ||
                currentWeather.coord?.lon == null) {
              return const Center(
                child: Text(
                  '',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontFamily: 'My3',
                  ),
                ),
              );
            }

            final lat = currentWeather.coord?.lat;
            final lon = currentWeather.coord?.lon;
            final validCoordinates = LatLng(lat!, lon!);

            return FlutterMap(
              key: ValueKey(validCoordinates),
              options: MapOptions(
                  initialCenter: validCoordinates,
                  initialZoom: 12.0,
                  minZoom: 10.0,
                  maxZoom: 10.0,
                  interactionOptions: const InteractionOptions(
                    flags: InteractiveFlag.none,
                  )),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 70.0,
                      height: 70.0,
                      point: validCoordinates,
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 40.0,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
