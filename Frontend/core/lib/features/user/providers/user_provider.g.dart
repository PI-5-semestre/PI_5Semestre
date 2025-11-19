// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserController)
const userControllerProvider = UserControllerProvider._();

final class UserControllerProvider
    extends $NotifierProvider<UserController, UserState> {
  const UserControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userControllerHash();

  @$internal
  @override
  UserController create() => UserController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserState>(value),
    );
  }
}

String _$userControllerHash() => r'fa09f3ac92b16f3c8085950a18fb5d68ed7d8286';

abstract class _$UserController extends $Notifier<UserState> {
  UserState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<UserState, UserState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UserState, UserState>,
              UserState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
