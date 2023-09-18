// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'segment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Segment _$SegmentFromJson(Map<String, dynamic> json) {
  return _Segment.fromJson(json);
}

/// @nodoc
mixin _$Segment {
  SegmentPoint get startCoordinates => throw _privateConstructorUsedError;
  SegmentPoint get endCoordinates => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SegmentCopyWith<Segment> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SegmentCopyWith<$Res> {
  factory $SegmentCopyWith(Segment value, $Res Function(Segment) then) =
      _$SegmentCopyWithImpl<$Res, Segment>;
  @useResult
  $Res call({SegmentPoint startCoordinates, SegmentPoint endCoordinates});

  $SegmentPointCopyWith<$Res> get startCoordinates;
  $SegmentPointCopyWith<$Res> get endCoordinates;
}

/// @nodoc
class _$SegmentCopyWithImpl<$Res, $Val extends Segment>
    implements $SegmentCopyWith<$Res> {
  _$SegmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startCoordinates = null,
    Object? endCoordinates = null,
  }) {
    return _then(_value.copyWith(
      startCoordinates: null == startCoordinates
          ? _value.startCoordinates
          : startCoordinates // ignore: cast_nullable_to_non_nullable
              as SegmentPoint,
      endCoordinates: null == endCoordinates
          ? _value.endCoordinates
          : endCoordinates // ignore: cast_nullable_to_non_nullable
              as SegmentPoint,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SegmentPointCopyWith<$Res> get startCoordinates {
    return $SegmentPointCopyWith<$Res>(_value.startCoordinates, (value) {
      return _then(_value.copyWith(startCoordinates: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SegmentPointCopyWith<$Res> get endCoordinates {
    return $SegmentPointCopyWith<$Res>(_value.endCoordinates, (value) {
      return _then(_value.copyWith(endCoordinates: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_SegmentCopyWith<$Res> implements $SegmentCopyWith<$Res> {
  factory _$$_SegmentCopyWith(
          _$_Segment value, $Res Function(_$_Segment) then) =
      __$$_SegmentCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SegmentPoint startCoordinates, SegmentPoint endCoordinates});

  @override
  $SegmentPointCopyWith<$Res> get startCoordinates;
  @override
  $SegmentPointCopyWith<$Res> get endCoordinates;
}

/// @nodoc
class __$$_SegmentCopyWithImpl<$Res>
    extends _$SegmentCopyWithImpl<$Res, _$_Segment>
    implements _$$_SegmentCopyWith<$Res> {
  __$$_SegmentCopyWithImpl(_$_Segment _value, $Res Function(_$_Segment) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startCoordinates = null,
    Object? endCoordinates = null,
  }) {
    return _then(_$_Segment(
      startCoordinates: null == startCoordinates
          ? _value.startCoordinates
          : startCoordinates // ignore: cast_nullable_to_non_nullable
              as SegmentPoint,
      endCoordinates: null == endCoordinates
          ? _value.endCoordinates
          : endCoordinates // ignore: cast_nullable_to_non_nullable
              as SegmentPoint,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Segment with DiagnosticableTreeMixin implements _Segment {
  const _$_Segment(
      {required this.startCoordinates, required this.endCoordinates});

  factory _$_Segment.fromJson(Map<String, dynamic> json) =>
      _$$_SegmentFromJson(json);

  @override
  final SegmentPoint startCoordinates;
  @override
  final SegmentPoint endCoordinates;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Segment(startCoordinates: $startCoordinates, endCoordinates: $endCoordinates)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Segment'))
      ..add(DiagnosticsProperty('startCoordinates', startCoordinates))
      ..add(DiagnosticsProperty('endCoordinates', endCoordinates));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Segment &&
            (identical(other.startCoordinates, startCoordinates) ||
                other.startCoordinates == startCoordinates) &&
            (identical(other.endCoordinates, endCoordinates) ||
                other.endCoordinates == endCoordinates));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, startCoordinates, endCoordinates);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SegmentCopyWith<_$_Segment> get copyWith =>
      __$$_SegmentCopyWithImpl<_$_Segment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SegmentToJson(
      this,
    );
  }
}

abstract class _Segment implements Segment {
  const factory _Segment(
      {required final SegmentPoint startCoordinates,
      required final SegmentPoint endCoordinates}) = _$_Segment;

  factory _Segment.fromJson(Map<String, dynamic> json) = _$_Segment.fromJson;

  @override
  SegmentPoint get startCoordinates;
  @override
  SegmentPoint get endCoordinates;
  @override
  @JsonKey(ignore: true)
  _$$_SegmentCopyWith<_$_Segment> get copyWith =>
      throw _privateConstructorUsedError;
}
