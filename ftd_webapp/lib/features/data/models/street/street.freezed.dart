// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'street.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Street _$StreetFromJson(Map<String, dynamic> json) {
  return _Street.fromJson(json);
}

/// @nodoc
mixin _$Street {
  String get uuid => throw _privateConstructorUsedError;
  set uuid(String value) => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  set id(String value) => throw _privateConstructorUsedError;
  String get dataset => throw _privateConstructorUsedError;
  set dataset(String value) => throw _privateConstructorUsedError;
  List<Segment> get segments => throw _privateConstructorUsedError;
  set segments(List<Segment> value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StreetCopyWith<Street> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StreetCopyWith<$Res> {
  factory $StreetCopyWith(Street value, $Res Function(Street) then) =
      _$StreetCopyWithImpl<$Res, Street>;
  @useResult
  $Res call({String uuid, String id, String dataset, List<Segment> segments});
}

/// @nodoc
class _$StreetCopyWithImpl<$Res, $Val extends Street>
    implements $StreetCopyWith<$Res> {
  _$StreetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? id = null,
    Object? dataset = null,
    Object? segments = null,
  }) {
    return _then(_value.copyWith(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      dataset: null == dataset
          ? _value.dataset
          : dataset // ignore: cast_nullable_to_non_nullable
              as String,
      segments: null == segments
          ? _value.segments
          : segments // ignore: cast_nullable_to_non_nullable
              as List<Segment>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_StreetCopyWith<$Res> implements $StreetCopyWith<$Res> {
  factory _$$_StreetCopyWith(_$_Street value, $Res Function(_$_Street) then) =
      __$$_StreetCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String uuid, String id, String dataset, List<Segment> segments});
}

/// @nodoc
class __$$_StreetCopyWithImpl<$Res>
    extends _$StreetCopyWithImpl<$Res, _$_Street>
    implements _$$_StreetCopyWith<$Res> {
  __$$_StreetCopyWithImpl(_$_Street _value, $Res Function(_$_Street) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? id = null,
    Object? dataset = null,
    Object? segments = null,
  }) {
    return _then(_$_Street(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      dataset: null == dataset
          ? _value.dataset
          : dataset // ignore: cast_nullable_to_non_nullable
              as String,
      segments: null == segments
          ? _value.segments
          : segments // ignore: cast_nullable_to_non_nullable
              as List<Segment>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Street with DiagnosticableTreeMixin implements _Street {
  _$_Street(
      {required this.uuid,
      required this.id,
      required this.dataset,
      required this.segments});

  factory _$_Street.fromJson(Map<String, dynamic> json) =>
      _$$_StreetFromJson(json);

  @override
  String uuid;
  @override
  String id;
  @override
  String dataset;
  @override
  List<Segment> segments;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Street(uuid: $uuid, id: $id, dataset: $dataset, segments: $segments)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Street'))
      ..add(DiagnosticsProperty('uuid', uuid))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('dataset', dataset))
      ..add(DiagnosticsProperty('segments', segments));
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StreetCopyWith<_$_Street> get copyWith =>
      __$$_StreetCopyWithImpl<_$_Street>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StreetToJson(
      this,
    );
  }
}

abstract class _Street implements Street {
  factory _Street(
      {required String uuid,
      required String id,
      required String dataset,
      required List<Segment> segments}) = _$_Street;

  factory _Street.fromJson(Map<String, dynamic> json) = _$_Street.fromJson;

  @override
  String get uuid;
  set uuid(String value);
  @override
  String get id;
  set id(String value);
  @override
  String get dataset;
  set dataset(String value);
  @override
  List<Segment> get segments;
  set segments(List<Segment> value);
  @override
  @JsonKey(ignore: true)
  _$$_StreetCopyWith<_$_Street> get copyWith =>
      throw _privateConstructorUsedError;
}
