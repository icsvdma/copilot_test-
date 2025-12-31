import '../models/camera.dart';

/// カメラデータを取得するサービス
class CameraService {
  /// 全てのカメラを取得
  Future<List<Camera>> getAllCameras() async {
    // 実際のAPIコールをシミュレートするため、わずかに遅延
    await Future.delayed(const Duration(milliseconds: 500));
    return Camera.getAllCameras();
  }

  /// 特定の地域のカメラを取得
  Future<List<Camera>> getCamerasByRegion(String regionId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Camera.getCamerasByRegion(regionId);
  }

  /// カメラIDで特定のカメラを取得
  Future<Camera?> getCameraById(String cameraId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return Camera.getAllCameras().firstWhere((camera) => camera.id == cameraId);
    } catch (e) {
      return null;
    }
  }

  /// カメラ画像URLを更新（リフレッシュ）
  Future<String> refreshCameraImage(String cameraId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final camera = await getCameraById(cameraId);
    if (camera != null) {
      // タイムスタンプを追加してキャッシュを回避
      return '${camera.imageUrl}&t=${DateTime.now().millisecondsSinceEpoch}';
    }
    return '';
  }
}
