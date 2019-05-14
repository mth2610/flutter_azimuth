import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:azimuth/azimuth.dart';

void main() {
  const MethodChannel channel = MethodChannel('azimuth');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Azimuth.platformVersion, '42');
  });
}
