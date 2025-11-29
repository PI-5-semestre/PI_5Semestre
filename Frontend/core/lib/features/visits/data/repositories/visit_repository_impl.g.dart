// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(visitRepository)
const visitRepositoryProvider = VisitRepositoryProvider._();

final class VisitRepositoryProvider
    extends
        $FunctionalProvider<VisitRepository, VisitRepository, VisitRepository>
    with $Provider<VisitRepository> {
  const VisitRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'visitRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$visitRepositoryHash();

  @$internal
  @override
  $ProviderElement<VisitRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VisitRepository create(Ref ref) {
    return visitRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VisitRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VisitRepository>(value),
    );
  }
}

String _$visitRepositoryHash() => r'7224626bb50daf1ad357bd8ad1fa7fb0ecf3d28c';
