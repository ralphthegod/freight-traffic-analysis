// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'street.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Street _$$_StreetFromJson(Map<String, dynamic> json) => _$_Street(
      uuid: json['uuid'] as String,
      id: json['id'] as String,
      dataset: json['dataset'] as String,
      segments: (json['segments'] as List<dynamic>)
          .map((e) => Segment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_StreetToJson(_$_Street instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'id': instance.id,
      'dataset': instance.dataset,
      'segments': instance.segments,
    };
