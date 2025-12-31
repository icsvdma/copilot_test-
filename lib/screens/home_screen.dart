import 'package:flutter/material.dart';
import '../models/region.dart';
import '../widgets/region_selector.dart';
import 'region_detail_screen.dart';

/// ホーム画面（地域選択）
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Region> _regions = Region.getAllRegions();
  String? _selectedRegionId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('山形県ライブカメラ'),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Column(
        children: [
          // ヘッダー部分
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.blue.shade300],
              ),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.videocam,
                  size: 64,
                  color: Colors.white,
                ),
                const SizedBox(height: 16),
                const Text(
                  '山形県内のライブカメラと気象情報',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  '各地域を選択してください',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // 地域選択
          RegionSelector(
            regions: _regions,
            selectedRegionId: _selectedRegionId,
            onRegionSelected: (region) {
              setState(() {
                _selectedRegionId = region.id;
              });
            },
          ),
          const SizedBox(height: 24),
          // 選択した地域の詳細へボタン
          if (_selectedRegionId != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final selectedRegion = _regions.firstWhere(
                      (region) => region.id == _selectedRegionId,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegionDetailScreen(
                          region: selectedRegion,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    '${_regions.firstWhere((r) => r.id == _selectedRegionId).name}の詳細を見る',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          const Spacer(),
          // フッター情報
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'データは定期的に更新されます',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '※ モックデータを使用しています',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
