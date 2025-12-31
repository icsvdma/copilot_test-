import 'package:flutter_test/flutter_test.dart';
import 'package:yamagata_live_camera/services/camera_service.dart';
import 'package:yamagata_live_camera/services/weather_service.dart';

void main() {
  group('CameraService Tests', () {
    late CameraService cameraService;

    setUp(() {
      cameraService = CameraService();
    });

    test('getAllCameras returns camera list', () async {
      final cameras = await cameraService.getAllCameras();
      expect(cameras.isNotEmpty, true);
    });

    test('getCamerasByRegion returns filtered cameras', () async {
      final cameras = await cameraService.getCamerasByRegion('murayama');
      expect(cameras.every((c) => c.regionId == 'murayama'), true);
    });

    test('getCameraById returns camera when exists', () async {
      final allCameras = await cameraService.getAllCameras();
      final firstCameraId = allCameras.first.id;
      
      final camera = await cameraService.getCameraById(firstCameraId);
      expect(camera, isNotNull);
      expect(camera!.id, firstCameraId);
    });

    test('getCameraById returns null when not exists', () async {
      final camera = await cameraService.getCameraById('non_existent_id');
      expect(camera, isNull);
    });
  });

  group('WeatherService Tests', () {
    late WeatherService weatherService;

    setUp(() {
      weatherService = WeatherService();
    });

    test('getAllWeatherData returns weather list', () async {
      final weatherData = await weatherService.getAllWeatherData();
      expect(weatherData.length, 4);
    });

    test('getWeatherByRegion returns correct weather', () async {
      final weather = await weatherService.getWeatherByRegion('murayama');
      expect(weather, isNotNull);
      expect(weather!.regionId, 'murayama');
    });

    test('refreshWeatherData returns updated data', () async {
      final weather = await weatherService.refreshWeatherData('murayama');
      expect(weather, isNotNull);
    });
  });
}
