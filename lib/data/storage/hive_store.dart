// Hive 저장소 - 게임 스냅샷 저장/로드

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/model/models.dart';

/// Hive 저장소 키
class StorageKeys {
  static const String gameBox = 'game_data';
  static const String snapshotKey = 'current_snapshot';
  static const String backupKey = 'backup_snapshot';
}

/// 게임 저장소 서비스
class GameStorage {
  Box<String>? _box;
  bool _initialized = false;

  /// 초기화
  Future<void> init() async {
    if (_initialized) return;

    await Hive.initFlutter();
    _box = await Hive.openBox<String>(StorageKeys.gameBox);
    _initialized = true;
  }

  /// 저장소 준비 확인
  bool get isReady => _initialized && _box != null;

  /// 스냅샷 저장
  Future<bool> saveSnapshot(GameSnapshot snapshot) async {
    if (!isReady) {
      await init();
    }

    try {
      // 현재 스냅샷을 백업으로 이동
      final current = _box!.get(StorageKeys.snapshotKey);
      if (current != null) {
        await _box!.put(StorageKeys.backupKey, current);
      }

      // 새 스냅샷 저장
      final json = jsonEncode(snapshot.toJson());
      await _box!.put(StorageKeys.snapshotKey, json);

      return true;
    } catch (e) {
      debugPrint('Error saving snapshot: $e');
      return false;
    }
  }

  /// 스냅샷 로드
  Future<GameSnapshot?> loadSnapshot() async {
    if (!isReady) {
      await init();
    }

    try {
      final json = _box!.get(StorageKeys.snapshotKey);
      if (json == null) return null;

      final Map<String, dynamic> data = jsonDecode(json);
      return GameSnapshot.fromJson(data);
    } catch (e) {
      debugPrint('Error loading snapshot: $e');
      // 백업에서 복구 시도
      return _loadBackup();
    }
  }

  /// 백업에서 복구
  Future<GameSnapshot?> _loadBackup() async {
    try {
      final json = _box!.get(StorageKeys.backupKey);
      if (json == null) return null;

      final Map<String, dynamic> data = jsonDecode(json);
      return GameSnapshot.fromJson(data);
    } catch (e) {
      debugPrint('Error loading backup: $e');
      return null;
    }
  }

  /// 저장된 게임 존재 여부
  Future<bool> hasSavedGame() async {
    if (!isReady) {
      await init();
    }
    return _box!.containsKey(StorageKeys.snapshotKey);
  }

  /// 저장된 게임 삭제
  Future<void> deleteSavedGame() async {
    if (!isReady) {
      await init();
    }
    await _box!.delete(StorageKeys.snapshotKey);
    await _box!.delete(StorageKeys.backupKey);
  }

  /// 저장소 닫기
  Future<void> close() async {
    await _box?.close();
    _initialized = false;
  }
}

/// 싱글톤 인스턴스
final gameStorage = GameStorage();
