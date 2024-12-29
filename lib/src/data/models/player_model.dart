class PlayerDetailModel {
  final String id;
  final String name;
  final String totalRuns;
  final String image;
  final String yps;
  final String dps;
  final String bestPer;
  final String age;
  final String type;
  final String stats;

  PlayerDetailModel({
    required this.id,
    required this.name,
    required this.totalRuns,
    required this.image,
    required this.yps,
    required this.dps,
    required this.bestPer,
    required this.age,
    required this.type,
    required this.stats,
  });

  factory PlayerDetailModel.fromMap(Map<String, dynamic> data,String id) {
    return PlayerDetailModel(
      id:id,
      name: data['name'],
      totalRuns: data['totalRuns'],
      image: data['image'],
      yps: data['yps'],
      dps: data['dps'],
      bestPer: data['bestPer'],
      age: data['age'],
      stats: data['stats'],
      type: data['type'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'totalRuns': totalRuns,
      'image': image,
      'yps': yps,
      'dps': dps,
      'bestPer': bestPer,
      'age': age,
      'type': type,
      'stats': stats,
    };
  }
}
