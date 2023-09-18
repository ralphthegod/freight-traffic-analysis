// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:ftd_webapp/features/data/models/segment/segment.dart';

part 'street.freezed.dart';
part 'street.g.dart';

@unfreezed
class Street with _$Street{
  factory Street({
    required String uuid,
    required String id,
    required String dataset,
    required List<Segment> segments

  }) = _Street;

  factory Street.fromJson(Map<String, dynamic> json) => _$StreetFromJson(json);

}