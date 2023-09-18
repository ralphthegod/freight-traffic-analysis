import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:ftd_webapp/features/data/models/segment_point/segment_point.dart';

part 'segment.freezed.dart';
part 'segment.g.dart';

@freezed
class Segment with _$Segment{
  const factory Segment({
    required SegmentPoint startCoordinates,
    required SegmentPoint endCoordinates
  }) = _Segment;

  factory Segment.fromJson(Map<String, dynamic> json) => _$SegmentFromJson(json);
}