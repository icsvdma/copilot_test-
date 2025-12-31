/// 気象情報を表すモデル
class Weather {
  final String regionId;
  final String regionName;
  final double temperature; // 気温（℃）
  final int snowDepth; // 積雪深（cm）
  final String condition; // 天気状況
  final String icon; // 天気アイコン
  final DateTime lastUpdated; // 最終更新日時

  Weather({
    required this.regionId,
    required this.regionName,
    required this.temperature,
    required this.snowDepth,
    required this.condition,
    required this.icon,
    required this.lastUpdated,
  });

  /// 地域IDで気象情報を取得
  static Weather? getWeatherByRegion(String regionId) {
    try {
      return getAllWeatherData().firstWhere(
        (weather) => weather.regionId == regionId,
      );
    } catch (e) {
      return null;
    }
  }

  /// 全地域の気象情報モックデータ
  static List<Weather> getAllWeatherData() {
    final now = DateTime.now();
    return [
      Weather(
        regionId: 'murayama',
        regionName: '村山',
        temperature: -2.5,
        snowDepth: 45,
        condition: '雪',
        icon: '🌨️',
        lastUpdated: now,
      ),
      Weather(
        regionId: 'mogami',
        regionName: '最上',
        temperature: -5.0,
        snowDepth: 120,
        condition: '雪',
        icon: '❄️',
        lastUpdated: now,
      ),
      Weather(
        regionId: 'okitama',
        regionName: '置賜',
        temperature: -3.0,
        snowDepth: 60,
        condition: '曇り',
        icon: '☁️',
        lastUpdated: now,
      ),
      Weather(
        regionId: 'shonai',
        regionName: '庄内',
        temperature: 2.0,
        snowDepth: 15,
        condition: '曇り',
        icon: '⛅',
        lastUpdated: now,
      ),
    ];
  }

  /// 温度を文字列に変換
  String getTemperatureDisplay() {
    return '${temperature.toStringAsFixed(1)}℃';
  }

  /// 積雪深を文字列に変換
  String getSnowDepthDisplay() {
    return '${snowDepth}cm';
  }
}
