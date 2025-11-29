// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'visits.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
Visit _$VisitFromJson(
  Map<String, dynamic> json
) {
    return _Visits.fromJson(
      json
    );
}

/// @nodoc
mixin _$Visit {

 int? get id; bool? get active; DateTime? get created; int? get institution_id; int get account_id; int? get family_id; String get visit_at; String? get description; String get type_of_visit; Response? get response; FamilyModel? get family;
/// Create a copy of Visit
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VisitCopyWith<Visit> get copyWith => _$VisitCopyWithImpl<Visit>(this as Visit, _$identity);

  /// Serializes this Visit to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Visit&&(identical(other.id, id) || other.id == id)&&(identical(other.active, active) || other.active == active)&&(identical(other.created, created) || other.created == created)&&(identical(other.institution_id, institution_id) || other.institution_id == institution_id)&&(identical(other.account_id, account_id) || other.account_id == account_id)&&(identical(other.family_id, family_id) || other.family_id == family_id)&&(identical(other.visit_at, visit_at) || other.visit_at == visit_at)&&(identical(other.description, description) || other.description == description)&&(identical(other.type_of_visit, type_of_visit) || other.type_of_visit == type_of_visit)&&(identical(other.response, response) || other.response == response)&&(identical(other.family, family) || other.family == family));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,active,created,institution_id,account_id,family_id,visit_at,description,type_of_visit,response,family);

@override
String toString() {
  return 'Visit(id: $id, active: $active, created: $created, institution_id: $institution_id, account_id: $account_id, family_id: $family_id, visit_at: $visit_at, description: $description, type_of_visit: $type_of_visit, response: $response, family: $family)';
}


}

/// @nodoc
abstract mixin class $VisitCopyWith<$Res>  {
  factory $VisitCopyWith(Visit value, $Res Function(Visit) _then) = _$VisitCopyWithImpl;
@useResult
$Res call({
 int? id, bool? active, DateTime? created, int? institution_id, int account_id, int? family_id, String visit_at, String? description, String type_of_visit, Response? response, FamilyModel? family
});


$ResponseCopyWith<$Res>? get response;$FamilyModelCopyWith<$Res>? get family;

}
/// @nodoc
class _$VisitCopyWithImpl<$Res>
    implements $VisitCopyWith<$Res> {
  _$VisitCopyWithImpl(this._self, this._then);

  final Visit _self;
  final $Res Function(Visit) _then;

/// Create a copy of Visit
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? active = freezed,Object? created = freezed,Object? institution_id = freezed,Object? account_id = null,Object? family_id = freezed,Object? visit_at = null,Object? description = freezed,Object? type_of_visit = null,Object? response = freezed,Object? family = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,active: freezed == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool?,created: freezed == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime?,institution_id: freezed == institution_id ? _self.institution_id : institution_id // ignore: cast_nullable_to_non_nullable
as int?,account_id: null == account_id ? _self.account_id : account_id // ignore: cast_nullable_to_non_nullable
as int,family_id: freezed == family_id ? _self.family_id : family_id // ignore: cast_nullable_to_non_nullable
as int?,visit_at: null == visit_at ? _self.visit_at : visit_at // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,type_of_visit: null == type_of_visit ? _self.type_of_visit : type_of_visit // ignore: cast_nullable_to_non_nullable
as String,response: freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as Response?,family: freezed == family ? _self.family : family // ignore: cast_nullable_to_non_nullable
as FamilyModel?,
  ));
}
/// Create a copy of Visit
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResponseCopyWith<$Res>? get response {
    if (_self.response == null) {
    return null;
  }

  return $ResponseCopyWith<$Res>(_self.response!, (value) {
    return _then(_self.copyWith(response: value));
  });
}/// Create a copy of Visit
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FamilyModelCopyWith<$Res>? get family {
    if (_self.family == null) {
    return null;
  }

  return $FamilyModelCopyWith<$Res>(_self.family!, (value) {
    return _then(_self.copyWith(family: value));
  });
}
}


/// Adds pattern-matching-related methods to [Visit].
extension VisitPatterns on Visit {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Visits value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Visits() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Visits value)  $default,){
final _that = this;
switch (_that) {
case _Visits():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Visits value)?  $default,){
final _that = this;
switch (_that) {
case _Visits() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  bool? active,  DateTime? created,  int? institution_id,  int account_id,  int? family_id,  String visit_at,  String? description,  String type_of_visit,  Response? response,  FamilyModel? family)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Visits() when $default != null:
return $default(_that.id,_that.active,_that.created,_that.institution_id,_that.account_id,_that.family_id,_that.visit_at,_that.description,_that.type_of_visit,_that.response,_that.family);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  bool? active,  DateTime? created,  int? institution_id,  int account_id,  int? family_id,  String visit_at,  String? description,  String type_of_visit,  Response? response,  FamilyModel? family)  $default,) {final _that = this;
switch (_that) {
case _Visits():
return $default(_that.id,_that.active,_that.created,_that.institution_id,_that.account_id,_that.family_id,_that.visit_at,_that.description,_that.type_of_visit,_that.response,_that.family);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  bool? active,  DateTime? created,  int? institution_id,  int account_id,  int? family_id,  String visit_at,  String? description,  String type_of_visit,  Response? response,  FamilyModel? family)?  $default,) {final _that = this;
switch (_that) {
case _Visits() when $default != null:
return $default(_that.id,_that.active,_that.created,_that.institution_id,_that.account_id,_that.family_id,_that.visit_at,_that.description,_that.type_of_visit,_that.response,_that.family);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Visits extends Visit {
  const _Visits({this.id, this.active, this.created, this.institution_id, required this.account_id, this.family_id, required this.visit_at, this.description, required this.type_of_visit, this.response, this.family}): super._();
  factory _Visits.fromJson(Map<String, dynamic> json) => _$VisitsFromJson(json);

@override final  int? id;
@override final  bool? active;
@override final  DateTime? created;
@override final  int? institution_id;
@override final  int account_id;
@override final  int? family_id;
@override final  String visit_at;
@override final  String? description;
@override final  String type_of_visit;
@override final  Response? response;
@override final  FamilyModel? family;

/// Create a copy of Visit
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VisitsCopyWith<_Visits> get copyWith => __$VisitsCopyWithImpl<_Visits>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VisitsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Visits&&(identical(other.id, id) || other.id == id)&&(identical(other.active, active) || other.active == active)&&(identical(other.created, created) || other.created == created)&&(identical(other.institution_id, institution_id) || other.institution_id == institution_id)&&(identical(other.account_id, account_id) || other.account_id == account_id)&&(identical(other.family_id, family_id) || other.family_id == family_id)&&(identical(other.visit_at, visit_at) || other.visit_at == visit_at)&&(identical(other.description, description) || other.description == description)&&(identical(other.type_of_visit, type_of_visit) || other.type_of_visit == type_of_visit)&&(identical(other.response, response) || other.response == response)&&(identical(other.family, family) || other.family == family));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,active,created,institution_id,account_id,family_id,visit_at,description,type_of_visit,response,family);

@override
String toString() {
  return 'Visit(id: $id, active: $active, created: $created, institution_id: $institution_id, account_id: $account_id, family_id: $family_id, visit_at: $visit_at, description: $description, type_of_visit: $type_of_visit, response: $response, family: $family)';
}


}

/// @nodoc
abstract mixin class _$VisitsCopyWith<$Res> implements $VisitCopyWith<$Res> {
  factory _$VisitsCopyWith(_Visits value, $Res Function(_Visits) _then) = __$VisitsCopyWithImpl;
@override @useResult
$Res call({
 int? id, bool? active, DateTime? created, int? institution_id, int account_id, int? family_id, String visit_at, String? description, String type_of_visit, Response? response, FamilyModel? family
});


@override $ResponseCopyWith<$Res>? get response;@override $FamilyModelCopyWith<$Res>? get family;

}
/// @nodoc
class __$VisitsCopyWithImpl<$Res>
    implements _$VisitsCopyWith<$Res> {
  __$VisitsCopyWithImpl(this._self, this._then);

  final _Visits _self;
  final $Res Function(_Visits) _then;

/// Create a copy of Visit
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? active = freezed,Object? created = freezed,Object? institution_id = freezed,Object? account_id = null,Object? family_id = freezed,Object? visit_at = null,Object? description = freezed,Object? type_of_visit = null,Object? response = freezed,Object? family = freezed,}) {
  return _then(_Visits(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,active: freezed == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool?,created: freezed == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime?,institution_id: freezed == institution_id ? _self.institution_id : institution_id // ignore: cast_nullable_to_non_nullable
as int?,account_id: null == account_id ? _self.account_id : account_id // ignore: cast_nullable_to_non_nullable
as int,family_id: freezed == family_id ? _self.family_id : family_id // ignore: cast_nullable_to_non_nullable
as int?,visit_at: null == visit_at ? _self.visit_at : visit_at // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,type_of_visit: null == type_of_visit ? _self.type_of_visit : type_of_visit // ignore: cast_nullable_to_non_nullable
as String,response: freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as Response?,family: freezed == family ? _self.family : family // ignore: cast_nullable_to_non_nullable
as FamilyModel?,
  ));
}

/// Create a copy of Visit
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResponseCopyWith<$Res>? get response {
    if (_self.response == null) {
    return null;
  }

  return $ResponseCopyWith<$Res>(_self.response!, (value) {
    return _then(_self.copyWith(response: value));
  });
}/// Create a copy of Visit
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FamilyModelCopyWith<$Res>? get family {
    if (_self.family == null) {
    return null;
  }

  return $FamilyModelCopyWith<$Res>(_self.family!, (value) {
    return _then(_self.copyWith(family: value));
  });
}
}


/// @nodoc
mixin _$Response {

 int? get visitation_id; String? get description; String? get status;
/// Create a copy of Response
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResponseCopyWith<Response> get copyWith => _$ResponseCopyWithImpl<Response>(this as Response, _$identity);

  /// Serializes this Response to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Response&&(identical(other.visitation_id, visitation_id) || other.visitation_id == visitation_id)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,visitation_id,description,status);

@override
String toString() {
  return 'Response(visitation_id: $visitation_id, description: $description, status: $status)';
}


}

/// @nodoc
abstract mixin class $ResponseCopyWith<$Res>  {
  factory $ResponseCopyWith(Response value, $Res Function(Response) _then) = _$ResponseCopyWithImpl;
@useResult
$Res call({
 int? visitation_id, String? description, String? status
});




}
/// @nodoc
class _$ResponseCopyWithImpl<$Res>
    implements $ResponseCopyWith<$Res> {
  _$ResponseCopyWithImpl(this._self, this._then);

  final Response _self;
  final $Res Function(Response) _then;

/// Create a copy of Response
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? visitation_id = freezed,Object? description = freezed,Object? status = freezed,}) {
  return _then(_self.copyWith(
visitation_id: freezed == visitation_id ? _self.visitation_id : visitation_id // ignore: cast_nullable_to_non_nullable
as int?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Response].
extension ResponsePatterns on Response {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Response value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Response() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Response value)  $default,){
final _that = this;
switch (_that) {
case _Response():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Response value)?  $default,){
final _that = this;
switch (_that) {
case _Response() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? visitation_id,  String? description,  String? status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Response() when $default != null:
return $default(_that.visitation_id,_that.description,_that.status);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? visitation_id,  String? description,  String? status)  $default,) {final _that = this;
switch (_that) {
case _Response():
return $default(_that.visitation_id,_that.description,_that.status);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? visitation_id,  String? description,  String? status)?  $default,) {final _that = this;
switch (_that) {
case _Response() when $default != null:
return $default(_that.visitation_id,_that.description,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Response extends Response {
  const _Response({this.visitation_id, this.description, this.status}): super._();
  factory _Response.fromJson(Map<String, dynamic> json) => _$ResponseFromJson(json);

@override final  int? visitation_id;
@override final  String? description;
@override final  String? status;

/// Create a copy of Response
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResponseCopyWith<_Response> get copyWith => __$ResponseCopyWithImpl<_Response>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Response&&(identical(other.visitation_id, visitation_id) || other.visitation_id == visitation_id)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,visitation_id,description,status);

@override
String toString() {
  return 'Response(visitation_id: $visitation_id, description: $description, status: $status)';
}


}

/// @nodoc
abstract mixin class _$ResponseCopyWith<$Res> implements $ResponseCopyWith<$Res> {
  factory _$ResponseCopyWith(_Response value, $Res Function(_Response) _then) = __$ResponseCopyWithImpl;
@override @useResult
$Res call({
 int? visitation_id, String? description, String? status
});




}
/// @nodoc
class __$ResponseCopyWithImpl<$Res>
    implements _$ResponseCopyWith<$Res> {
  __$ResponseCopyWithImpl(this._self, this._then);

  final _Response _self;
  final $Res Function(_Response) _then;

/// Create a copy of Response
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? visitation_id = freezed,Object? description = freezed,Object? status = freezed,}) {
  return _then(_Response(
visitation_id: freezed == visitation_id ? _self.visitation_id : visitation_id // ignore: cast_nullable_to_non_nullable
as int?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
