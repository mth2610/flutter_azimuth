import 'dart:async';
import 'package:flutter/services.dart';

const EventChannel _azimuthChannel = EventChannel('plugins.flutter.io/sensors/azimuth');

class AzimuthEvent {
  AzimuthEvent(this.azimuth);

  final double azimuth;
  @override
  String toString() => 'azimuth: $azimuth';
}

AzimuthEvent _toAzimuthEvent(double value) {
  return AzimuthEvent(value);
}

Stream<AzimuthEvent> _azimuthEvents;
Stream<AzimuthEvent> get azimuthEvents {
  if (_azimuthEvents == null) {
    _azimuthEvents = _azimuthChannel
        .receiveBroadcastStream()
        .map((dynamic event) => _toAzimuthEvent(event));
  }
  return _azimuthEvents;
}
