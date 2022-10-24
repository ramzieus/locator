import 'package:geolocator/geolocator.dart';

class RPosition extends Position {
  RPosition(
      {required this.name,
      required super.longitude,
      required super.latitude,
      required super.timestamp,
      required super.accuracy,
      required this.notified,
      required super.altitude,
      required super.heading,
      required super.speed,
      required super.speedAccuracy});

  late bool notified;
  final String name;
}
