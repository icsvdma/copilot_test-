import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const YamagataLiveCameraApp());
}

/// 山形県ライブカメラアプリのメインクラス
class YamagataLiveCameraApp extends StatelessWidget {
  const YamagataLiveCameraApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '山形県ライブカメラ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        // 日本語フォント設定
        fontFamily: 'Noto Sans JP',
        // テーマカラー設定
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        // AppBarテーマ
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        // カードテーマ
        cardTheme: CardTheme(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        // ElevatedButtonテーマ
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 2,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
