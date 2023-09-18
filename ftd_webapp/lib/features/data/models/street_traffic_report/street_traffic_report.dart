// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'street_traffic_report.freezed.dart';
part 'street_traffic_report.g.dart';

@freezed
class StreetTrafficReport with _$StreetTrafficReport{
  factory StreetTrafficReport({
    required String streetUUID,
    required double maxTraffic,
    required double minTraffic,
    required double avgTraffic,
    required double sumTraffic,
    required double maxVelocity,
    required double avgVelocity
  }) = _StreetTrafficReport;

  factory StreetTrafficReport.fromJson(Map<String, dynamic> json) => _$StreetTrafficReportFromJson(json);

  factory StreetTrafficReport.empty(String uuid) => StreetTrafficReport(
    streetUUID: uuid,
    maxTraffic: 0,
    minTraffic: 0,
    avgTraffic: 0,
    sumTraffic: 0,
    maxVelocity: 0,
    avgVelocity: 0
  );

}