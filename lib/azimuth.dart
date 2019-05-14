import 'dart:async';
import 'package:flutter/services.dart';

const EventChannel _azimuthChannel = EventChannel('plugins.flutter.io/sensors/azimuth');

class AzimuthEvent {
  AzimuthEvent(this.azimuth);

  /// Acceleration force along the x axis (including gravity) measured in m/s^2.
  final int azimuth;
  @override
  String toString() => 'azimuth: $azimuth';
}

AzimuthEvent _toAzimuthEvent(int value) {
  return AzimuthEvent(value);
}

Stream<AzimuthEvent> _azimuthEvents;
/// A broadcast stream of events from the device accelerometer.
Stream<AzimuthEvent> get azimuthEvents {
  if (_azimuthEvents == null) {
    _azimuthEvents = _azimuthChannel
        .receiveBroadcastStream()
        .map((dynamic event) => _toAzimuthEvent(event));
  }
  return _azimuthEvents;
}
