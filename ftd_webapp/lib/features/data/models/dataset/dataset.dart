import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'dataset.freezed.dart';
part 'dataset.g.dart';

@freezed
class Dataset with _$Dataset{
  const factory Dataset({
    required String name,
    required int totalStreets,
    required int totalEvents
  }) = _Dataset;

  factory Dataset.fromJson(Map<String, dynamic> json) => _$DatasetFromJson(json);

}