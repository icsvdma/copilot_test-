import '../models/weather.dart';

/// 気象データを取得するサービス
class WeatherService {
  /// 全地域の気象データを取得
  Future<List<Weather>> getAllWeatherData() async {
    // 実際のAPIコールをシミュレートするため、わずかに遅延
    await Future.delayed(const Duration(milliseconds: 500));
    return Weather.getAllWeatherData();
  }

  /// 特定の地域の気象データを取得
  Future<Weather?> getWeatherByRegion(String regionId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Weather.getWeatherByRegion(regionId);
  }

  /// 気象データを更新（リフレッシュ）
  Future<Weather?> refreshWeatherData(String regionId) async {
    // 実際のAPI実装では、最新のデータを取得
    return await getWeatherByRegion(regionId);
  }
}
