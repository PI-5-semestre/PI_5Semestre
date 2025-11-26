// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prefs_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(prefsProvider)
const prefsProviderProvider = PrefsProviderProvider._();

final class PrefsProviderProvider
    extends
        $FunctionalProvider<
          AsyncValue<SharedPreferences>,
          SharedPreferences,
          FutureOr<SharedPreferences>
        >
    with
        $FutureModifier<SharedPreferences>,
        $FutureProvider<SharedPreferences> {
  const PrefsProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'prefsProviderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$prefsProviderHash();

  @$internal
  @override
  $FutureProviderElement<SharedPreferences> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SharedPreferences> create(Ref ref) {
    return prefsProvider(ref);
  }
}

String _$prefsProviderHash() => r'aeaef7dff81d66b1593c7670a511550a099c2d2a';
