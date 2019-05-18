import 'dart:async';
import 'package:flutter/services.dart';

const EventChannel _azimuthChannel = EventChannel('plugins.flutter.io/sensors/azimuth');

class AzimuthEvent {
  AzimuthEvent(
    this.azimuth,
    this.magnitude
  );

  final double azimuth;
  final double magnitude;

  @override
  String toString() => 'azimuth: $azimuth ; magnitude: $magnitude';
}

AzimuthEvent _toAzimuthEvent(double azimuth, double magnitude) {
  return AzimuthEvent(azimuth, magnitude);
}

Stream<AzimuthEvent> _azimuthEvents;
Stream<AzimuthEvent> get azimuthEvents {
  if (_azimuthEvents == null) {
    _azimuthEvents = _azimuthChannel
        .receiveBroadcastStream()
        .map((dynamic event) => _toAzimuthEvent(event[0], event[1]));
  }
  return _azimuthEvents;
}
