// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cep_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(cepRepositoryImpl)
const cepRepositoryImplProvider = CepRepositoryImplProvider._();

final class CepRepositoryImplProvider
    extends
        $FunctionalProvider<
          CepRepositoryImpl,
          CepRepositoryImpl,
          CepRepositoryImpl
        >
    with $Provider<CepRepositoryImpl> {
  const CepRepositoryImplProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cepRepositoryImplProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cepRepositoryImplHash();

  @$internal
  @override
  $ProviderElement<CepRepositoryImpl> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CepRepositoryImpl create(Ref ref) {
    return cepRepositoryImpl(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CepRepositoryImpl value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CepRepositoryImpl>(value),
    );
  }
}

String _$cepRepositoryImplHash() => r'af149620c0495d37222c07001f8b92cd5ab6f924';
