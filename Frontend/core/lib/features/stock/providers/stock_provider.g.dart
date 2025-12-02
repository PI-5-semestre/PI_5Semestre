// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(StockController)
const stockControllerProvider = StockControllerProvider._();

final class StockControllerProvider
    extends $NotifierProvider<StockController, StockState> {
  const StockControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'stockControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$stockControllerHash();

  @$internal
  @override
  StockController create() => StockController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StockState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StockState>(value),
    );
  }
}

String _$stockControllerHash() => r'a15d7b8900821397ecc9f4d87316d85fed4ef168';

abstract class _$StockController extends $Notifier<StockState> {
  StockState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<StockState, StockState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<StockState, StockState>,
              StockState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
