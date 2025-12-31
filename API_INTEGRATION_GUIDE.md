# API統合ガイド

このドキュメントでは、モックデータから実際のAPIへの移行方法を説明します。

## 現在のアーキテクチャ

```
UI Layer (Screens/Widgets)
    ↓
Service Layer (CameraService, WeatherService) ← モックデータを返す
    ↓
Model Layer (Camera, Weather, Region) ← データ構造定義
```

## API統合の手順

### 1. HTTPクライアントの追加

`pubspec.yaml`に依存関係を追加:

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0  # HTTPクライアント
  # または
  dio: ^5.3.0   # より高機能なHTTPクライアント
```

### 2. CameraServiceの実装例

現在のコード（モックデータ）:

```dart
// lib/services/camera_service.dart
class CameraService {
  Future<List<Camera>> getAllCameras() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Camera.getAllCameras();  // モックデータ
  }
}
```

API実装版:

```dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/camera.dart';

class CameraService {
  final String baseUrl = 'https://api.example.com/yamagata';
  
  Future<List<Camera>> getAllCameras() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/cameras'),
        headers: {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Camera.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load cameras: ${response.statusCode}');
      }
    } catch (e) {
      // エラーハンドリング
      print('Error fetching cameras: $e');
      // フォールバック: モックデータを返す
      return Camera.getAllCameras();
    }
  }
  
  Future<List<Camera>> getCamerasByRegion(String regionId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/cameras?region=$regionId'),
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Camera.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load cameras for region');
      }
    } catch (e) {
      print('Error: $e');
      return Camera.getCamerasByRegion(regionId);
    }
  }
}
```

### 3. Cameraモデルの拡張

`fromJson`メソッドと`toJson`メソッドを追加:

```dart
// lib/models/camera.dart
class Camera {
  final String id;
  final String name;
  // ... 既存のフィールド
  
  Camera({
    required this.id,
    required this.name,
    // ... 既存のコンストラクタ
  });
  
  // JSONからCameraオブジェクトを生成
  factory Camera.fromJson(Map<String, dynamic> json) {
    return Camera(
      id: json['id'] as String,
      name: json['name'] as String,
      regionId: json['region_id'] as String,
      location: json['location'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      imageUrl: json['image_url'] as String,
      description: json['description'] as String,
    );
  }
  
  // CameraオブジェクトをJSONに変換
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'region_id': regionId,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'image_url': imageUrl,
      'description': description,
    };
  }
}
```

### 4. WeatherServiceの実装例

```dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/weather.dart';

class WeatherService {
  final String baseUrl = 'https://api.example.com/yamagata';
  
  Future<List<Weather>> getAllWeatherData() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/weather'),
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Weather.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print('Error: $e');
      return Weather.getAllWeatherData();
    }
  }
  
  Future<Weather?> getWeatherByRegion(String regionId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/weather/$regionId'),
      );
      
      if (response.statusCode == 200) {
        return Weather.fromJson(json.decode(response.body));
      }
      return null;
    } catch (e) {
      print('Error: $e');
      return Weather.getWeatherByRegion(regionId);
    }
  }
}
```

### 5. Weatherモデルの拡張

```dart
// lib/models/weather.dart
class Weather {
  // ... 既存のフィールド
  
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      regionId: json['region_id'] as String,
      regionName: json['region_name'] as String,
      temperature: (json['temperature'] as num).toDouble(),
      snowDepth: json['snow_depth'] as int,
      condition: json['condition'] as String,
      icon: json['icon'] as String,
      lastUpdated: DateTime.parse(json['last_updated'] as String),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'region_id': regionId,
      'region_name': regionName,
      'temperature': temperature,
      'snow_depth': snowDepth,
      'condition': condition,
      'icon': icon,
      'last_updated': lastUpdated.toIso8601String(),
    };
  }
}
```

## 想定APIレスポンス形式

### カメラ一覧 (GET /api/cameras)

```json
[
  {
    "id": "cam_murayama_01",
    "name": "山形市街地",
    "region_id": "murayama",
    "location": "山形市役所付近",
    "latitude": 38.2404,
    "longitude": 140.3633,
    "image_url": "https://example.com/cameras/murayama_01.jpg",
    "description": "山形市中心部の様子"
  }
]
```

### 気象情報 (GET /api/weather/murayama)

```json
{
  "region_id": "murayama",
  "region_name": "村山",
  "temperature": -2.5,
  "snow_depth": 45,
  "condition": "雪",
  "icon": "🌨️",
  "last_updated": "2025-12-31T13:19:00Z"
}
```

## エラーハンドリング

```dart
class CameraService {
  Future<List<Camera>> getAllCameras() async {
    try {
      final response = await http.get(/* ... */);
      
      if (response.statusCode == 200) {
        return parseResponse(response.body);
      } else if (response.statusCode == 404) {
        throw CameraNotFoundException();
      } else if (response.statusCode == 500) {
        throw ServerException();
      } else {
        throw UnknownException();
      }
    } on SocketException {
      throw NoInternetException();
    } on TimeoutException {
      throw RequestTimeoutException();
    } catch (e) {
      throw UnknownException();
    }
  }
}
```

## キャッシング戦略

```dart
class CameraService {
  final Duration cacheTimeout = Duration(minutes: 5);
  List<Camera>? _cachedCameras;
  DateTime? _lastFetchTime;
  
  Future<List<Camera>> getAllCameras() async {
    // キャッシュが有効かチェック
    if (_cachedCameras != null && _lastFetchTime != null) {
      if (DateTime.now().difference(_lastFetchTime!) < cacheTimeout) {
        return _cachedCameras!;
      }
    }
    
    // APIから取得
    final cameras = await _fetchFromApi();
    
    // キャッシュを更新
    _cachedCameras = cameras;
    _lastFetchTime = DateTime.now();
    
    return cameras;
  }
}
```

## 環境設定

開発環境とプロダクション環境で異なるAPIエンドポイントを使用:

```dart
// lib/config/environment.dart
class Environment {
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.example.com/yamagata',
  );
  
  static const bool useMockData = bool.fromEnvironment(
    'USE_MOCK_DATA',
    defaultValue: true,
  );
}

// lib/services/camera_service.dart
class CameraService {
  final String baseUrl = Environment.apiBaseUrl;
  
  Future<List<Camera>> getAllCameras() async {
    if (Environment.useMockData) {
      return Camera.getAllCameras();
    }
    
    // 実際のAPI呼び出し
    // ...
  }
}
```

実行時に環境変数を指定:

```bash
# モックデータを使用
flutter run --dart-define=USE_MOCK_DATA=true

# 実際のAPIを使用
flutter run --dart-define=USE_MOCK_DATA=false --dart-define=API_BASE_URL=https://api.yamagata.jp
```

## まとめ

API統合の手順:
1. HTTPクライアント（http/dio）の追加
2. モデルに`fromJson`/`toJson`メソッドを追加
3. サービス層でAPI呼び出しを実装
4. エラーハンドリングを追加
5. キャッシング戦略を実装（オプション）
6. 環境設定で開発/本番を切り替え

**重要**: UIレイヤー（Screens/Widgets）は変更不要です！
