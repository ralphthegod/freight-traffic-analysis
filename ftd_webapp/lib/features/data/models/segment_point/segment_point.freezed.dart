// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'segment_point.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SegmentPoint _$SegmentPointFromJson(Map<String, dynamic> json) {
  return _SegmentPoint.fromJson(json);
}

/// @nodoc
mixin _$SegmentPoint {
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SegmentPointCopyWith<SegmentPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SegmentPointCopyWith<$Res> {
  factory $SegmentPointCopyWith(
          SegmentPoint value, $Res Function(SegmentPoint) then) =
      _$SegmentPointCopyWithImpl<$Res, SegmentPoint>;
  @useResult
  $Res call({double latitude, double longitude});
}

/// @nodoc
class _$SegmentPointCopyWithImpl<$Res, $Val extends SegmentPoint>
    implements $SegmentPointCopyWith<$Res> {
  _$SegmentPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_value.copyWith(
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SegmentPointCopyWith<$Res>
    implements $SegmentPointCopyWith<$Res> {
  factory _$$_SegmentPointCopyWith(
          _$_SegmentPoint value, $Res Function(_$_SegmentPoint) then) =
      __$$_SegmentPointCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double latitude, double longitude});
}

/// @nodoc
class __$$_SegmentPointCopyWithImpl<$Res>
    extends _$SegmentPointCopyWithImpl<$Res, _$_SegmentPoint>
    implements _$$_SegmentPointCopyWith<$Res> {
  __$$_SegmentPointCopyWithImpl(
      _$_SegmentPoint _value, $Res Function(_$_SegmentPoint) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_$_SegmentPoint(
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SegmentPoint with DiagnosticableTreeMixin implements _SegmentPoint {
  const _$_SegmentPoint({required this.latitude, required this.longitude});

  factory _$_SegmentPoint.fromJson(Map<String, dynamic> json) =>
      _$$_SegmentPointFromJson(json);

  @override
  final double latitude;
  @override
  final double longitude;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SegmentPoint(latitude: $latitude, longitude: $longitude)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SegmentPoint'))
      ..add(DiagnosticsProperty('latitude', latitude))
      ..add(DiagnosticsProperty('longitude', longitude));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SegmentPoint &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, latitude, longitude);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SegmentPointCopyWith<_$_SegmentPoint> get copyWith =>
      __$$_SegmentPointCopyWithImpl<_$_SegmentPoint>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SegmentPointToJson(
      this,
    );
  }
}

abstract class _SegmentPoint implements SegmentPoint {
  const factory _SegmentPoint(
      {required final double latitude,
      required final double longitude}) = _$_SegmentPoint;

  factory _SegmentPoint.fromJson(Map<String, dynamic> json) =
      _$_SegmentPoint.fromJson;

  @override
  double get latitude;
  @override
  double get longitude;
  @override
  @JsonKey(ignore: true)
  _$$_SegmentPointCopyWith<_$_SegmentPoint> get copyWith =>
      throw _privateConstructorUsedError;
}
