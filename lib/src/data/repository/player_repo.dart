import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cricket_app/src/data/models/player_model.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerRepository {
  final FirebaseFirestore _firestore;

  PlayerRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<PlayerDetailModel>> fetchPlayers() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      /// Fetch players from local storage
      final box = await Hive.openBox('players');
      final players = box.values.map((e) => PlayerDetailModel.fromMap(Map<String, dynamic>.from(e), e['id'])).toList();
      return players;
    } else {
      /// Fetch players from Firebase
      final snapshot = await _firestore.collection('players').get();
      final players = snapshot.docs.map((doc) => PlayerDetailModel.fromMap(doc.data(), doc.id)).toList();
      /// Save players to local storage
      final box = await Hive.openBox('players');
      await box.clear();
      for (var player in players) {
        await box.put(player.id, player.toMap());
      }
      return players;
    }
  }
  Future<void> editPlayerDetails(String playerId, String totalRuns, String yps, String dps) async {
    final prefs = await SharedPreferences.getInstance();
    final connectivityResult = await Connectivity().checkConnectivity();

    /// Save changes locally
    final box = await Hive.openBox('players');
    final player = box.get(playerId);
    if (player != null) {
      player['totalRuns'] = totalRuns;
      player['yps'] = yps;
      player['dps'] = dps;
      await box.put(playerId, player);
    }
    await prefs.setString('totalRuns_$playerId', totalRuns);
    await prefs.setString('yps_$playerId', yps);
    await prefs.setString('dps_$playerId', dps);

    /// If online, sync changes with Firebase
    if (!connectivityResult.contains(ConnectivityResult.none)) {
      await _firestore.collection('players').doc(playerId).update({
        'totalRuns': totalRuns,
        'yps': yps,
        'dps': dps,
      });
    }
  }
  Future<void> syncLocalChanges() async {
    final prefs = await SharedPreferences.getInstance();
    final connectivityResult = await Connectivity().checkConnectivity();

    if (!connectivityResult.contains(ConnectivityResult.none)) {
      final keys = prefs.getKeys();
      for (String key in keys) {
        if (key.startsWith('totalRuns_')) {
          final playerId = key.split('_')[1];
          final totalRuns = prefs.getString('totalRuns_$playerId') ?? "0";
          final yps = prefs.getString('yps_$playerId') ?? "0";
          final dps = prefs.getString('dps_$playerId') ?? "0";

          await _firestore.collection('players').doc(playerId).update({
            'totalRuns': totalRuns,
            'yps': yps,
            'dps': dps,
          });

          /// Remove local changes after syncing
          await prefs.remove('totalRuns_$playerId');
          await prefs.remove('yps_$playerId');
          await prefs.remove('dps_$playerId');
        }
      }
    }
  }
}