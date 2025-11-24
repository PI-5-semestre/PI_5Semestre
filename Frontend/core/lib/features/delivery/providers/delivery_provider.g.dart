// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DeliveryController)
const deliveryControllerProvider = DeliveryControllerProvider._();

final class DeliveryControllerProvider
    extends $NotifierProvider<DeliveryController, DeliveryState> {
  const DeliveryControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deliveryControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deliveryControllerHash();

  @$internal
  @override
  DeliveryController create() => DeliveryController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeliveryState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeliveryState>(value),
    );
  }
}

String _$deliveryControllerHash() =>
    r'93fbe8bd50d09de53ef48f3c7524d49cd5446887';

abstract class _$DeliveryController extends $Notifier<DeliveryState> {
  DeliveryState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<DeliveryState, DeliveryState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DeliveryState, DeliveryState>,
              DeliveryState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
