import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'prefs_provider.g.dart';

@riverpod
Future<SharedPreferences> prefsProvider(Ref ref) async {
  return await SharedPreferences.getInstance();
}
