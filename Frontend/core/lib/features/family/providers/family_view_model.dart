import 'package:core/features/family/data/models/family_model.dart';
import 'package:core/features/family/data/repositories/family_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'family_view_model.g.dart';

@riverpod
class FamilyViewModel extends _$FamilyViewModel {
  @override
  Future<List<FamilyModel>> build() async {
    return await ref.read(familyRepositoryProvider).findAll();
  }
}
