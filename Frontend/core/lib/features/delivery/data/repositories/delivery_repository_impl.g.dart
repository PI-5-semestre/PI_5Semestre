// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deliveryRepository)
const deliveryRepositoryProvider = DeliveryRepositoryProvider._();

final class DeliveryRepositoryProvider
    extends
        $FunctionalProvider<
          DeliveryRepositoryImpl,
          DeliveryRepositoryImpl,
          DeliveryRepositoryImpl
        >
    with $Provider<DeliveryRepositoryImpl> {
  const DeliveryRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deliveryRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deliveryRepositoryHash();

  @$internal
  @override
  $ProviderElement<DeliveryRepositoryImpl> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeliveryRepositoryImpl create(Ref ref) {
    return deliveryRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeliveryRepositoryImpl value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeliveryRepositoryImpl>(value),
    );
  }
}

String _$deliveryRepositoryHash() =>
    r'3cfef7be76cc3d9480e16f46b951781c71c1ca1f';
