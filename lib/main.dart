import 'package:background_location/background_location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:locator/notification.dart' as notif;

import 'model.dart';

const fetchBackground = "fetchBackground";

Position desiredPosition = Position(
    longitude: 2.9511043,
    latitude: 36.6822183,
    timestamp: DateTime(2022),
    accuracy: 0,
    altitude: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0);

List<RPosition> desiredPositions = [
  // home
  RPosition(
      name: 'Home',
      longitude: 2.9511043,
      latitude: 36.6822183,
      timestamp: DateTime(2022),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0,
      notified: false),
  // anpt
  RPosition(
      name: 'ANPT',
      longitude: 2.9020082,
      latitude: 36.6786498,
      timestamp: DateTime(2022),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0,
      notified: false),
  // pharmacy
  RPosition(
      name: 'Pharmacy',
      longitude: 2.9511043,
      latitude: 36.6822183,
      timestamp: DateTime(2022),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0,
      notified: false),
  // Gendarme
  RPosition(
      name: 'Gendarme',
      longitude: 2.9514189,
      latitude: 36.6816843,
      timestamp: DateTime(2022),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0,
      notified: false),
  // mon reeve
  RPosition(
      name: 'Mon Réve',
      longitude: 2.9020082,
      latitude: 36.6786498,
      timestamp: DateTime(2022),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0,
      notified: false),
  // WAFA
  RPosition(
      name: 'WAFA',
      longitude: 2.8977338,
      latitude: 36.6788078,
      timestamp: DateTime(2022),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0,
      notified: false),
];

// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     switch (task) {
//       case fetchBackground:
//         //Geolocator geoLocator = Geolocator()..forceAndroidLocationManager = true;
//
//         Position userLocation = await Geolocator.getCurrentPosition(
//             desiredAccuracy: LocationAccuracy.low);
//
//         double distanceInMeters = Geolocator.distanceBetween(
//             userLocation.latitude,
//             userLocation.longitude,
//             desiredPosition.latitude,
//             desiredPosition.longitude);
//         if (distanceInMeters <= 1000.0) {
//           notif.Notification notification = notif.Notification();
//           notification.showNotificationWithoutSound(userLocation);
//         }
//         break;
//     }
//     return Future.value(true);
//   });
// }

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _initWorker() async {
    // await Geolocator.requestPermission();
    // Workmanager().initialize(
    //   callbackDispatcher,
    //   isInDebugMode: false,
    // );
    //
    // Workmanager().registerPeriodicTask(
    //   "1",
    //   fetchBackground,
    //   frequency: const Duration(minutes: 1),
    // );

    await BackgroundLocation.startLocationService();
    BackgroundLocation.getLocationUpdates((location) {
      print(location.speed.toString());

      for (var desiredPosition in desiredPositions) {
        double distanceInMeters = Geolocator.distanceBetween(
            location.latitude!,
            location.longitude!,
            desiredPosition.latitude,
            desiredPosition.longitude);
        if (distanceInMeters <= 1000.0 && !desiredPosition.notified) {
          desiredPosition.notified = true;
          notif.Notification notification = notif.Notification();
          notification.showNotificationWithoutSound(desiredPosition);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _initWorker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "",
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Geolocator.requestPermission();
        },
        child: const Icon(Icons.location_on),
      ),
    );
  }
}
