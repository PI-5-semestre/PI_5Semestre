// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BasketController)
const basketControllerProvider = BasketControllerProvider._();

final class BasketControllerProvider
    extends $NotifierProvider<BasketController, dynamic> {
  const BasketControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'basketControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$basketControllerHash();

  @$internal
  @override
  BasketController create() => BasketController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(dynamic value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<dynamic>(value),
    );
  }
}

String _$basketControllerHash() => r'0665b1f6e00134f7963d4fb4993bb8529b6ab4af';

abstract class _$BasketController extends $Notifier<dynamic> {
  dynamic build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<dynamic, dynamic>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<dynamic, dynamic>,
              dynamic,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
