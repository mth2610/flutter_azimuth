package com.mth2610.azimuth;

import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import io.flutter.plugin.common.EventChannel;

import io.flutter.plugin.common.PluginRegistry.Registrar;

/** AzimuthPlugin */
public class AzimuthPlugin implements EventChannel.StreamHandler {
  private static final String AZIMUTH_CHANNEL_NAME = "plugins.flutter.io/sensors/azimuth";
  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final EventChannel azimuthChannel = new EventChannel(registrar.messenger(), AZIMUTH_CHANNEL_NAME);
    azimuthChannel.setStreamHandler(new AzimuthPlugin(registrar.context()));
  }

  private SensorEventListener sensorEventListener;
  private final SensorManager sensorManager;
  private final Sensor accelSensor;
  private final Sensor magneticSensor;

  private AzimuthPlugin(Context context) {
    sensorManager = (SensorManager) context.getSystemService(context.SENSOR_SERVICE);
    accelSensor = sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
    magneticSensor = sensorManager.getDefaultSensor(Sensor.TYPE_MAGNETIC_FIELD);
  }

  @Override
  public void onListen(Object arguments, EventChannel.EventSink events) {
    sensorEventListener = createSensorEventListener(events);
    sensorManager.registerListener(sensorEventListener, accelSensor, sensorManager.SENSOR_DELAY_NORMAL);
    sensorManager.registerListener(sensorEventListener, magneticSensor, sensorManager.SENSOR_DELAY_NORMAL);
  }

  @Override
  public void onCancel(Object arguments) {
    sensorManager.unregisterListener(sensorEventListener);
  }

  SensorEventListener createSensorEventListener(final EventChannel.EventSink events) {
    return new SensorEventListener() {
      float[] gData = new float[3]; // accelerometer
      float[] mData = new float[3]; // magnetometer
      float[] rMat = new float[9];
      float[] iMat = new float[9];
      float[] orientation = new float[3];
      float azimuth;
      @Override
      public void onAccuracyChanged(Sensor sensor, int accuracy) {}

      @Override
      public void onSensorChanged(SensorEvent event) {
        float[] data;
        switch ( event.sensor.getType() ) {
          case Sensor.TYPE_ACCELEROMETER:
            gData = event.values.clone();
            break;
          case Sensor.TYPE_MAGNETIC_FIELD:
            mData = event.values.clone();
            break;
          default: return;
        }

        if (SensorManager.getRotationMatrix( rMat, iMat, gData, mData )){
          azimuth = SensorManager.getOrientation( rMat, orientation )[0]+2*3.14159265359f;
          events.success(azimuth);
        }
      }
    };
  }

}
