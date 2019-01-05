import 'package:json_annotation/json_annotation.dart';
import 'volume_model.dart';
part 'beer_model.g.dart';

class BeerList{

}

@JsonSerializable()
class Beer {
  int id;
  String name;
  @JsonKey(name: 'tag_line')
  String tagLine;
  @JsonKey(name: 'first_brewed')
  String firstBrewed;
  String description;
  @JsonKey(name: 'image_url')
  String imageUrl;
  double abv;
  double ibu;
  @JsonKey(name: 'target_fg')
  double targetFg;
  @JsonKey(name: 'target_og')
  double targetOg;
  double ebc;
  double srm;
  Volume volume;
  @JsonKey(name: 'boil_volume')
  Volume boilVolume;
  double ph;
  @JsonKey(name: 'attenuation_level')
  double attenuationLevel;
  @JsonKey(name: 'food_pairing')
  List<String> foodPairing;
  @JsonKey(name: 'brewers_tips')
  String brewersTips;

  Beer({
    this.id,
    this.name,
    this.tagLine,
    this.firstBrewed,
    this.description,
    this.imageUrl,
    this.abv,
    this.ibu,
    this.targetFg,
    this.targetOg,
    this.ebc,
    this.srm,
    this.volume,
    this.boilVolume,
    this.ph,
    this.attenuationLevel,
    this.foodPairing,
    this.brewersTips
  });

  factory Beer.fromJson(Map<String, dynamic> json) => _$BeerFromJson(json);
}
