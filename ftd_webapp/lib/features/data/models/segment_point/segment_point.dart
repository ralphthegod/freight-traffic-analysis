import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'segment_point.freezed.dart';
part 'segment_point.g.dart';

@freezed
class SegmentPoint with _$SegmentPoint{
  const factory SegmentPoint({
    required double latitude,
    required double longitude
  }) = _SegmentPoint;

  factory SegmentPoint.fromJson(Map<String, dynamic> json) => _$SegmentPointFromJson(json);

}