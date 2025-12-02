// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(basketRepository)
const basketRepositoryProvider = BasketRepositoryProvider._();

final class BasketRepositoryProvider
    extends
        $FunctionalProvider<
          BasketRepositoryImpl,
          BasketRepositoryImpl,
          BasketRepositoryImpl
        >
    with $Provider<BasketRepositoryImpl> {
  const BasketRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'basketRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$basketRepositoryHash();

  @$internal
  @override
  $ProviderElement<BasketRepositoryImpl> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BasketRepositoryImpl create(Ref ref) {
    return basketRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BasketRepositoryImpl value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BasketRepositoryImpl>(value),
    );
  }
}

String _$basketRepositoryHash() => r'029a63786fea98d284a9db6e82307d2bbc3f4e4c';
