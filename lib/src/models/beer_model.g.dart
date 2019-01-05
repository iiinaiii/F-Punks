// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Beer _$BeerFromJson(Map<String, dynamic> json) {
  return Beer(
      id: json['id'] as int,
      name: json['name'] as String,
      tagLine: json['tag_line'] as String,
      firstBrewed: json['first_brewed'] as String,
      description: json['description'] as String,
      imageUrl: json['image_url'] as String,
      abv: (json['abv'] as num)?.toDouble(),
      ibu: (json['ibu'] as num)?.toDouble(),
      targetFg: (json['target_fg'] as num)?.toDouble(),
      targetOg: (json['target_og'] as num)?.toDouble(),
      ebc: (json['ebc'] as num)?.toDouble(),
      srm: (json['srm'] as num)?.toDouble(),
      volume: json['volume'] == null
          ? null
          : Volume.fromJson(json['volume'] as Map<String, dynamic>),
      boilVolume: json['boil_volume'] == null
          ? null
          : Volume.fromJson(json['boil_volume'] as Map<String, dynamic>),
      ph: (json['ph'] as num)?.toDouble(),
      attenuationLevel: (json['attenuation_level'] as num)?.toDouble(),
      foodPairing:
          (json['food_pairing'] as List)?.map((e) => e as String)?.toList(),
      brewersTips: json['brewers_tips'] as String);
}

Map<String, dynamic> _$BeerToJson(Beer instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'tag_line': instance.tagLine,
      'first_brewed': instance.firstBrewed,
      'description': instance.description,
      'image_url': instance.imageUrl,
      'abv': instance.abv,
      'ibu': instance.ibu,
      'target_fg': instance.targetFg,
      'target_og': instance.targetOg,
      'ebc': instance.ebc,
      'srm': instance.srm,
      'volume': instance.volume,
      'boil_volume': instance.boilVolume,
      'ph': instance.ph,
      'attenuation_level': instance.attenuationLevel,
      'food_pairing': instance.foodPairing,
      'brewers_tips': instance.brewersTips
    };
