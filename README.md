# 山形県ライブカメラ・気象情報アプリ

山形県の各地域のライブカメラと積雪量、気温などの情報を表示・確認できるAndroid向けFlutterアプリです。

## 概要

このアプリは山形県内の4つの地域（村山・最上・置賜・庄内）のライブカメラ映像と気象情報を提供します。

### 主な機能

1. **ライブカメラ表示**
   - 山形県内の各地域のライブカメラ映像/画像を表示
   - カメラ一覧から選択して詳細表示
   - カメラの位置情報（緯度・経度）表示
   - 画像の手動リフレッシュ機能

2. **気象情報表示**
   - 各地域の現在の気温表示
   - 積雪深（積雪量）の表示
   - 天気状況の表示（天気アイコン付き）
   - 最終更新日時の表示

3. **地域選択**
   - 山形県の4つの地域から選択可能
     - 村山地域（山形市中心）
     - 最上地域（新庄市中心）
     - 置賜地域（米沢市中心）
     - 庄内地域（酒田市・鶴岡市中心）
   - 地域ごとにカメラと気象情報をフィルタリング

## プロジェクト構成

```
lib/
├── main.dart                      # アプリのエントリーポイント
├── models/                        # データモデル
│   ├── camera.dart                # ライブカメラデータモデル
│   ├── weather.dart               # 気象データモデル
│   └── region.dart                # 地域データモデル
├── services/                      # サービス層
│   ├── camera_service.dart        # カメラデータ取得サービス
│   └── weather_service.dart       # 気象データ取得サービス
├── screens/                       # 画面
│   ├── home_screen.dart           # ホーム画面（地域選択）
│   ├── region_detail_screen.dart  # 地域詳細画面
│   └── camera_detail_screen.dart  # カメラ詳細画面
└── widgets/                       # 再利用可能なウィジェット
    ├── camera_card.dart           # カメラカードウィジェット
    ├── weather_info_card.dart     # 気象情報カードウィジェット
    └── region_selector.dart       # 地域選択ウィジェット
```

## 技術スタック

- **フレームワーク**: Flutter (Dart)
- **対象プラットフォーム**: Android
- **アーキテクチャ**: レイヤー分離アーキテクチャ（Models, Services, Screens, Widgets）
- **UIフレームワーク**: Material Design 3

## セットアップ

### 前提条件

- Flutter SDK (3.0.0以上)
- Android Studio または VS Code
- Android SDK
- Dart SDK

### インストール手順

1. リポジトリをクローン
```bash
git clone https://github.com/icsvdma/copilot_test-.git
cd copilot_test-
```

2. 依存関係をインストール
```bash
flutter pub get
```

3. Android エミュレータを起動、または実機を接続

4. アプリを実行
```bash
flutter run
```

### ビルド

APKファイルを生成:
```bash
flutter build apk --release
```

App Bundleを生成:
```bash
flutter build appbundle --release
```

## 使い方

1. **ホーム画面**
   - アプリを起動すると、4つの地域選択カードが表示されます
   - 見たい地域をタップして選択します
   - 「〇〇の詳細を見る」ボタンをタップします

2. **地域詳細画面**
   - 選択した地域の気象情報（気温、積雪深、天気）が上部に表示されます
   - 下にスクロールすると、その地域のライブカメラ一覧が表示されます
   - 見たいカメラをタップすると詳細画面に移動します
   - 右上の更新ボタンで情報をリフレッシュできます
   - 下に引っ張って離す（Pull to Refresh）でも更新できます

3. **カメラ詳細画面**
   - カメラの映像/画像が大きく表示されます
   - カメラの場所、座標、説明が表示されます
   - 右上の更新ボタンまたは下部のボタンで画像を更新できます

## データについて

現在のバージョンでは、モックデータ（サンプルデータ）を使用しています。

### 今後の拡張

実際のAPIに接続するには、`services`層を以下のように実装します：

```dart
// 実際のAPIエンドポイントに接続
class CameraService {
  final String baseUrl = 'https://api.example.com';
  
  Future<List<Camera>> getAllCameras() async {
    final response = await http.get(Uri.parse('$baseUrl/cameras'));
    // レスポンスをパースしてCameraオブジェクトに変換
  }
}
```

サービス層が分離されているため、モデルや画面の変更なしにAPI実装を追加できます。

## ライセンス

このプロジェクトはサンプルアプリケーションです。

## 貢献

プルリクエストを歓迎します。大きな変更の場合は、まずissueを開いて変更内容を議論してください。

## 作者

Copilot Workspace

## 更新履歴

### v1.0.0 (2025-12-31)
- 初回リリース
- 4地域のライブカメラ表示機能
- 気象情報表示機能
- 地域選択機能