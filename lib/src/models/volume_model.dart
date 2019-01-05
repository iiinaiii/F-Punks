import 'package:json_annotation/json_annotation.dart';
part 'volume_model.g.dart';

@JsonSerializable()
class Volume {
  int value;
  String unit;

  Volume({this.value, this.unit});
  factory Volume.fromJson(Map<String, dynamic> json) => _$VolumeFromJson(json);
}
