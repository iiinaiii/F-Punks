import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import 'beer_response_model.dart';

class Beer {
  int id;
  String name;
  String tagLine;
  String firstBrewed;
  String description;
  String imageUrl;
  String abv;
  String ibu;
  String targetOg;
  String targetFg;
  String ebc;
  String srm;
  String volume;
  String boilVolume;
  String ph;
  String attenuationLevel;
  List<String> foodPairing;
  String brewersTips;

  Beer({
    @required this.id,
    @required this.name,
    @required this.tagLine,
    @required this.firstBrewed,
    @required this.description,
    @required this.imageUrl,
    @required this.abv,
    @required this.ibu,
    @required this.targetOg,
    @required this.targetFg,
    @required this.ebc,
    @required this.srm,
    @required this.volume,
    @required this.boilVolume,
    @required this.ph,
    @required this.attenuationLevel,
    @required this.foodPairing,
    @required this.brewersTips,
  });

  factory Beer.fromBeerResponse(BeerResponse beerResponse) {
    return Beer(
      id: beerResponse.id,
      name: beerResponse.name,
      tagLine: beerResponse.tagLine,
      firstBrewed: toDateOrDefault(beerResponse.firstBrewed),
      description: beerResponse.description,
      imageUrl: toImageUrlOrDefault(beerResponse.imageUrl),
      abv: "${toStringOrDefault(beerResponse.abv)}%",
      ibu: toStringOrDefault(beerResponse.ibu),
      targetOg: toStringOrDefault(beerResponse.targetOg),
      targetFg: toStringOrDefault(beerResponse.targetFg),
      ebc: toStringOrDefault(beerResponse.ebc),
      srm: toStringOrDefault(beerResponse.srm),
      volume: beerResponse.volume.toVolumeText(),
      boilVolume: beerResponse.boilVolume.toVolumeText(),
      ph: toStringOrDefault(beerResponse.ph),
      attenuationLevel: toStringOrDefault(beerResponse.attenuationLevel),
      foodPairing: beerResponse.foodPairing,
      brewersTips: beerResponse.brewersTips,
    );
  }
}

String toDateOrDefault(String date) {
  if (date != null) {
    DateFormat dateFormat;
    String formatStr;
    if (date.length == 4) {
      dateFormat = DateFormat.y("en_US");
      formatStr = "yyyy";
    } else {
      dateFormat = DateFormat.yMMMM("en_US");
      formatStr = "MM/yyyy";
    }
    return dateFormat.format(DateFormat(formatStr).parse(date)).toUpperCase();
  }
  return "-";
}

String toImageUrlOrDefault(String imageUrl) {
  return imageUrl ?? "https://images.punkapi.com/v2/keg.png";
}

String toStringOrDefault(double value) {
  if (value != null) {
    return value.toString();
  }
  return "-";
}
