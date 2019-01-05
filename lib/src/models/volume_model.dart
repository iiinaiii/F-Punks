import 'package:json_annotation/json_annotation.dart';

import '../util/value_unit.dart';

part 'volume_model.g.dart';

@JsonSerializable()
class Volume {
  int value;
  String unit;

  Volume({this.value, this.unit});

  factory Volume.fromJson(Map<String, dynamic> json) => _$VolumeFromJson(json);

  String toVolumeText() {
    return value.toString() + convertVolumeName(unit);
  }
}
