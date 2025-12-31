/// 山形県の地域を表すモデル
class Region {
  final String id;
  final String name;
  final String description;

  Region({
    required this.id,
    required this.name,
    required this.description,
  });

  /// 山形県の4つの地域
  static List<Region> getAllRegions() {
    return [
      Region(
        id: 'murayama',
        name: '村山',
        description: '山形市を中心とした県の中心地域',
      ),
      Region(
        id: 'mogami',
        name: '最上',
        description: '新庄市を中心とした県の北東部地域',
      ),
      Region(
        id: 'okitama',
        name: '置賜',
        description: '米沢市を中心とした県の南部地域',
      ),
      Region(
        id: 'shonai',
        name: '庄内',
        description: '酒田市・鶴岡市を中心とした日本海沿岸地域',
      ),
    ];
  }
}
