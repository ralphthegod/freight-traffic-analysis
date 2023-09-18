// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'segment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Segment _$$_SegmentFromJson(Map<String, dynamic> json) => _$_Segment(
      startCoordinates: SegmentPoint.fromJson(
          json['startCoordinates'] as Map<String, dynamic>),
      endCoordinates:
          SegmentPoint.fromJson(json['endCoordinates'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_SegmentToJson(_$_Segment instance) =>
    <String, dynamic>{
      'startCoordinates': instance.startCoordinates,
      'endCoordinates': instance.endCoordinates,
    };
