// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FamilyController)
const familyControllerProvider = FamilyControllerProvider._();

final class FamilyControllerProvider
    extends $NotifierProvider<FamilyController, FamilyState> {
  const FamilyControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'familyControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$familyControllerHash();

  @$internal
  @override
  FamilyController create() => FamilyController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FamilyState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FamilyState>(value),
    );
  }
}

String _$familyControllerHash() => r'3e4d4db1ad940fe8aa30c177d04807add9c3b8b2';

abstract class _$FamilyController extends $Notifier<FamilyState> {
  FamilyState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<FamilyState, FamilyState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FamilyState, FamilyState>,
              FamilyState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
