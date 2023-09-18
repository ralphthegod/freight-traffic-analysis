// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'street_traffic_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_StreetTrafficReport _$$_StreetTrafficReportFromJson(
        Map<String, dynamic> json) =>
    _$_StreetTrafficReport(
      streetUUID: json['streetUUID'] as String,
      maxTraffic: (json['maxTraffic'] as num).toDouble(),
      minTraffic: (json['minTraffic'] as num).toDouble(),
      avgTraffic: (json['avgTraffic'] as num).toDouble(),
      sumTraffic: (json['sumTraffic'] as num).toDouble(),
      maxVelocity: (json['maxVelocity'] as num).toDouble(),
      avgVelocity: (json['avgVelocity'] as num).toDouble(),
    );

Map<String, dynamic> _$$_StreetTrafficReportToJson(
        _$_StreetTrafficReport instance) =>
    <String, dynamic>{
      'streetUUID': instance.streetUUID,
      'maxTraffic': instance.maxTraffic,
      'minTraffic': instance.minTraffic,
      'avgTraffic': instance.avgTraffic,
      'sumTraffic': instance.sumTraffic,
      'maxVelocity': instance.maxVelocity,
      'avgVelocity': instance.avgVelocity,
    };
