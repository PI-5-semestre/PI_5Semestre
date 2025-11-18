import 'package:core/models/Family/family_model.dart';
import 'package:core/repositories/family/family_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'new_family_view_model.g.dart';

@riverpod
class NewFamilyViewModel extends _$NewFamilyViewModel {
  @override
  void build() {}

  Future<bool> create(FamilyModel family) async {
    return await ref.read(familyRepositoryProvider).create(family);
  }
}
