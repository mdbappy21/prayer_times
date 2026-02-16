import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:prayer_time/ui/utility/app_colors.dart';
import 'package:vector_math/vector_math.dart' as vm;

class QiblaCompassScreen extends StatefulWidget {
  const QiblaCompassScreen({super.key});

  @override
  State<QiblaCompassScreen> createState() => _QiblaCompassScreenState();
}

class _QiblaCompassScreenState extends State<QiblaCompassScreen> {
  // Kaaba coordinates
  static const double _kaabaLat = 21.4225;
  static const double _kaabaLng = 39.8262;

  double _qiblaDirection = 0.0;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    try {
      final position = await _getLocation();
      _qiblaDirection = _calculateQibla(
        position.latitude,
        position.longitude,
      );
      setState(() => _loading = false);
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Future<Position> _getLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location service is disabled');
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw Exception('Location permission denied');
    }

    return Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 0,
      ),
    );
  }

  double _calculateQibla(double lat, double lng) {
    final latRad = vm.radians(lat);
    final lngRad = vm.radians(lng);
    final kaabaLatRad = vm.radians(_kaabaLat);
    final kaabaLngRad = vm.radians(_kaabaLng);

    final y = sin(kaabaLngRad - lngRad);
    final x = cos(latRad) * tan(kaabaLatRad) -
        sin(latRad) * cos(kaabaLngRad - lngRad);

    return (vm.degrees(atan2(y, x)) + 360) % 360;
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Qibla Compass',style: Theme.of(context).textTheme.titleMedium),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Center(
        child: _loading ? const CircularProgressIndicator() :
        (
            _error != null ?
            Text(_error!, style: const TextStyle(color: Colors.redAccent),) :
            _buildCompass(size)
        ),
      ),
    );
  }

  Widget _buildCompass(Size size) {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Text(
            'Sensor not available',
            style: TextStyle(color: Colors.white),
          );
        }

        final heading = snapshot.data!.heading;
        if (heading == null) {
          return const Text(
            'Calibrating compass...',
            style: TextStyle(color: Colors.white),
          );
        }

        final double headingRad = -heading * pi / 180;

        final double qiblaRad =
            (_qiblaDirection - heading) * pi / 180;

        final double qiblaOffset =
            (_qiblaDirection - heading + 360) % 360;

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/compass_bg.png',
                  width: size.width*.95,
                ),

                Positioned(
                  top: 14,
                  child: Container(
                    width: 4,
                    height: 28,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),

                Transform.rotate(
                  angle: headingRad,
                  child: Image.asset(
                    'assets/images/compass_dial.png',
                    width: size.width*.95,
                  ),
                ),
                Transform.rotate(
                  angle: qiblaRad,
                  child: Image.asset(
                    'assets/images/qibla_arrow.png',
                    width: size.width*.4,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            Text(
              '${qiblaOffset.toStringAsFixed(1)}°',
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'to Qibla',
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 10),
            const Text(
              'Keep the phone flat for accuracy',
              style: TextStyle(color: Colors.black),
            ),
          ],
        );
      },
    );
  }
}
