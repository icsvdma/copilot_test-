import 'package:flutter_test/flutter_test.dart';
import 'package:yamagata_live_camera/models/region.dart';
import 'package:yamagata_live_camera/models/camera.dart';
import 'package:yamagata_live_camera/models/weather.dart';

void main() {
  group('Region Model Tests', () {
    test('getAllRegions returns 4 regions', () {
      final regions = Region.getAllRegions();
      expect(regions.length, 4);
    });

    test('regions have correct IDs', () {
      final regions = Region.getAllRegions();
      final ids = regions.map((r) => r.id).toList();
      expect(ids, containsAll(['murayama', 'mogami', 'okitama', 'shonai']));
    });
  });

  group('Camera Model Tests', () {
    test('getAllCameras returns cameras', () {
      final cameras = Camera.getAllCameras();
      expect(cameras.isNotEmpty, true);
    });

    test('getCamerasByRegion filters correctly', () {
      final murayamaCameras = Camera.getCamerasByRegion('murayama');
      expect(murayamaCameras.every((c) => c.regionId == 'murayama'), true);
    });

    test('each region has at least one camera', () {
      final regions = Region.getAllRegions();
      for (final region in regions) {
        final cameras = Camera.getCamerasByRegion(region.id);
        expect(cameras.isNotEmpty, true,
            reason: 'Region ${region.name} should have cameras');
      }
    });
  });

  group('Weather Model Tests', () {
    test('getAllWeatherData returns 4 weather entries', () {
      final weatherData = Weather.getAllWeatherData();
      expect(weatherData.length, 4);
    });

    test('getWeatherByRegion returns correct weather', () {
      final weather = Weather.getWeatherByRegion('murayama');
      expect(weather, isNotNull);
      expect(weather!.regionId, 'murayama');
    });

    test('temperature display formats correctly', () {
      final weather = Weather.getAllWeatherData().first;
      final tempDisplay = weather.getTemperatureDisplay();
      expect(tempDisplay.contains('℃'), true);
    });

    test('snow depth display formats correctly', () {
      final weather = Weather.getAllWeatherData().first;
      final snowDisplay = weather.getSnowDepthDisplay();
      expect(snowDisplay.contains('cm'), true);
    });
  });
}
