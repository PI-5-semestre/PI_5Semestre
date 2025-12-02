// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VisitController)
const visitControllerProvider = VisitControllerProvider._();

final class VisitControllerProvider
    extends $NotifierProvider<VisitController, VisitState> {
  const VisitControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'visitControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$visitControllerHash();

  @$internal
  @override
  VisitController create() => VisitController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VisitState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VisitState>(value),
    );
  }
}

String _$visitControllerHash() => r'b2aed5bdc5f729bf510c302273728d86308833fd';

abstract class _$VisitController extends $Notifier<VisitState> {
  VisitState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<VisitState, VisitState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<VisitState, VisitState>,
              VisitState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
