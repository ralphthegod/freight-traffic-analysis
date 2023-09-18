// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dataset.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Dataset _$DatasetFromJson(Map<String, dynamic> json) {
  return _Dataset.fromJson(json);
}

/// @nodoc
mixin _$Dataset {
  String get name => throw _privateConstructorUsedError;
  int get totalStreets => throw _privateConstructorUsedError;
  int get totalEvents => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DatasetCopyWith<Dataset> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DatasetCopyWith<$Res> {
  factory $DatasetCopyWith(Dataset value, $Res Function(Dataset) then) =
      _$DatasetCopyWithImpl<$Res, Dataset>;
  @useResult
  $Res call({String name, int totalStreets, int totalEvents});
}

/// @nodoc
class _$DatasetCopyWithImpl<$Res, $Val extends Dataset>
    implements $DatasetCopyWith<$Res> {
  _$DatasetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? totalStreets = null,
    Object? totalEvents = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      totalStreets: null == totalStreets
          ? _value.totalStreets
          : totalStreets // ignore: cast_nullable_to_non_nullable
              as int,
      totalEvents: null == totalEvents
          ? _value.totalEvents
          : totalEvents // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DatasetCopyWith<$Res> implements $DatasetCopyWith<$Res> {
  factory _$$_DatasetCopyWith(
          _$_Dataset value, $Res Function(_$_Dataset) then) =
      __$$_DatasetCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, int totalStreets, int totalEvents});
}

/// @nodoc
class __$$_DatasetCopyWithImpl<$Res>
    extends _$DatasetCopyWithImpl<$Res, _$_Dataset>
    implements _$$_DatasetCopyWith<$Res> {
  __$$_DatasetCopyWithImpl(_$_Dataset _value, $Res Function(_$_Dataset) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? totalStreets = null,
    Object? totalEvents = null,
  }) {
    return _then(_$_Dataset(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      totalStreets: null == totalStreets
          ? _value.totalStreets
          : totalStreets // ignore: cast_nullable_to_non_nullable
              as int,
      totalEvents: null == totalEvents
          ? _value.totalEvents
          : totalEvents // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Dataset with DiagnosticableTreeMixin implements _Dataset {
  const _$_Dataset(
      {required this.name,
      required this.totalStreets,
      required this.totalEvents});

  factory _$_Dataset.fromJson(Map<String, dynamic> json) =>
      _$$_DatasetFromJson(json);

  @override
  final String name;
  @override
  final int totalStreets;
  @override
  final int totalEvents;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Dataset(name: $name, totalStreets: $totalStreets, totalEvents: $totalEvents)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Dataset'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('totalStreets', totalStreets))
      ..add(DiagnosticsProperty('totalEvents', totalEvents));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Dataset &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.totalStreets, totalStreets) ||
                other.totalStreets == totalStreets) &&
            (identical(other.totalEvents, totalEvents) ||
                other.totalEvents == totalEvents));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, totalStreets, totalEvents);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DatasetCopyWith<_$_Dataset> get copyWith =>
      __$$_DatasetCopyWithImpl<_$_Dataset>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DatasetToJson(
      this,
    );
  }
}

abstract class _Dataset implements Dataset {
  const factory _Dataset(
      {required final String name,
      required final int totalStreets,
      required final int totalEvents}) = _$_Dataset;

  factory _Dataset.fromJson(Map<String, dynamic> json) = _$_Dataset.fromJson;

  @override
  String get name;
  @override
  int get totalStreets;
  @override
  int get totalEvents;
  @override
  @JsonKey(ignore: true)
  _$$_DatasetCopyWith<_$_Dataset> get copyWith =>
      throw _privateConstructorUsedError;
}
