// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_family_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NewFamilyViewModel)
const newFamilyViewModelProvider = NewFamilyViewModelProvider._();

final class NewFamilyViewModelProvider
    extends $NotifierProvider<NewFamilyViewModel, void> {
  const NewFamilyViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'newFamilyViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$newFamilyViewModelHash();

  @$internal
  @override
  NewFamilyViewModel create() => NewFamilyViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$newFamilyViewModelHash() =>
    r'97c44bb4c21a234fe58de3949d1b2fa820ecae4c';

abstract class _$NewFamilyViewModel extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
