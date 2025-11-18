// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FamilyViewModel)
const familyViewModelProvider = FamilyViewModelProvider._();

final class FamilyViewModelProvider
    extends $AsyncNotifierProvider<FamilyViewModel, List<FamilyModel>> {
  const FamilyViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'familyViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$familyViewModelHash();

  @$internal
  @override
  FamilyViewModel create() => FamilyViewModel();
}

String _$familyViewModelHash() => r'6040dd25bf6b5ba6d3d02b256e4422a9d2e563ff';

abstract class _$FamilyViewModel extends $AsyncNotifier<List<FamilyModel>> {
  FutureOr<List<FamilyModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<FamilyModel>>, List<FamilyModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<FamilyModel>>, List<FamilyModel>>,
              AsyncValue<List<FamilyModel>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
