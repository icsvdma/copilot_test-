/// ライブカメラを表すモデル
class Camera {
  final String id;
  final String name;
  final String regionId;
  final String location;
  final double latitude;
  final double longitude;
  final String imageUrl;
  final String description;

  Camera({
    required this.id,
    required this.name,
    required this.regionId,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.imageUrl,
    required this.description,
  });

  /// 地域IDでフィルタリングされたカメラリストを取得
  static List<Camera> getCamerasByRegion(String regionId) {
    return getAllCameras().where((camera) => camera.regionId == regionId).toList();
  }

  /// 全カメラのモックデータ
  static List<Camera> getAllCameras() {
    return [
      // 村山地域
      Camera(
        id: 'cam_murayama_01',
        name: '山形市街地',
        regionId: 'murayama',
        location: '山形市役所付近',
        latitude: 38.2404,
        longitude: 140.3633,
        imageUrl: 'https://via.placeholder.com/640x480.png?text=山形市街地',
        description: '山形市中心部の様子',
      ),
      Camera(
        id: 'cam_murayama_02',
        name: '蔵王温泉スキー場',
        regionId: 'murayama',
        location: '蔵王温泉',
        latitude: 38.1405,
        longitude: 140.4450,
        imageUrl: 'https://via.placeholder.com/640x480.png?text=蔵王温泉',
        description: '蔵王温泉スキー場の積雪状況',
      ),
      // 最上地域
      Camera(
        id: 'cam_mogami_01',
        name: '新庄市街地',
        regionId: 'mogami',
        location: '新庄市役所付近',
        latitude: 38.7647,
        longitude: 140.3006,
        imageUrl: 'https://via.placeholder.com/640x480.png?text=新庄市街地',
        description: '新庄市中心部の様子',
      ),
      Camera(
        id: 'cam_mogami_02',
        name: '肘折温泉',
        regionId: 'mogami',
        location: '大蔵村肘折',
        latitude: 38.5425,
        longitude: 140.1894,
        imageUrl: 'https://via.placeholder.com/640x480.png?text=肘折温泉',
        description: '豪雪地帯の肘折温泉',
      ),
      // 置賜地域
      Camera(
        id: 'cam_okitama_01',
        name: '米沢市街地',
        regionId: 'okitama',
        location: '米沢市役所付近',
        latitude: 37.9165,
        longitude: 140.1147,
        imageUrl: 'https://via.placeholder.com/640x480.png?text=米沢市街地',
        description: '米沢市中心部の様子',
      ),
      Camera(
        id: 'cam_okitama_02',
        name: '白布温泉スキー場',
        regionId: 'okitama',
        location: '白布温泉',
        latitude: 37.7803,
        longitude: 140.0861,
        imageUrl: 'https://via.placeholder.com/640x480.png?text=白布温泉',
        description: '白布温泉スキー場の積雪状況',
      ),
      // 庄内地域
      Camera(
        id: 'cam_shonai_01',
        name: '酒田市街地',
        regionId: 'shonai',
        location: '酒田市役所付近',
        latitude: 38.9144,
        longitude: 139.8358,
        imageUrl: 'https://via.placeholder.com/640x480.png?text=酒田市街地',
        description: '酒田市中心部の様子',
      ),
      Camera(
        id: 'cam_shonai_02',
        name: '鶴岡市街地',
        regionId: 'shonai',
        location: '鶴岡市役所付近',
        latitude: 38.7276,
        longitude: 139.8267,
        imageUrl: 'https://via.placeholder.com/640x480.png?text=鶴岡市街地',
        description: '鶴岡市中心部の様子',
      ),
    ];
  }
}
