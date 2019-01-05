// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'volume_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Volume _$VolumeFromJson(Map<String, dynamic> json) {
  return Volume(value: json['value'] as int, unit: json['unit'] as String);
}

Map<String, dynamic> _$VolumeToJson(Volume instance) =>
    <String, dynamic>{'value': instance.value, 'unit': instance.unit};
