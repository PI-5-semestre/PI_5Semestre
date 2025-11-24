import 'package:core/features/shared_preferences/providers/prefs_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'storage_service.g.dart';

@riverpod
class StorageService extends _$StorageService {
  @override
  void build() {} // Este provider não mantém estado

  Future<void> set(String key, dynamic value) async {
    final prefs = await ref.read(prefsProviderProvider.future);

    if (value is String) await prefs.setString(key, value);
    else if (value is int) await prefs.setInt(key, value);
    else if (value is bool) await prefs.setBool(key, value);
    else if (value is double) await prefs.setDouble(key, value);
    else if (value is List<String>) await prefs.setStringList(key, value);
    else {
      throw Exception("Tipo não suportado para SharedPreferences.");
    }
  }

  Future<T?> get<T>(String key) async {
    final prefs = await ref.read(prefsProviderProvider.future);
    final value = prefs.get(key);

    if (value is T) return value;
    return null;
  }

  Future<void> remove(String key) async {
    final prefs = await ref.read(prefsProviderProvider.future);
    await prefs.remove(key);
  }

  Future<void> clear() async {
    final prefs = await ref.read(prefsProviderProvider.future);
    await prefs.clear();
  }
}
