// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cep_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ViaCep)
const viaCepProvider = ViaCepProvider._();

final class ViaCepProvider extends $AsyncNotifierProvider<ViaCep, Cep?> {
  const ViaCepProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'viaCepProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$viaCepHash();

  @$internal
  @override
  ViaCep create() => ViaCep();
}

String _$viaCepHash() => r'581ae179104ff33d31878bd3454c2a85264f0b6a';

abstract class _$ViaCep extends $AsyncNotifier<Cep?> {
  FutureOr<Cep?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<Cep?>, Cep?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Cep?>, Cep?>,
              AsyncValue<Cep?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
