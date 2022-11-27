import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

@JsonSerializable()
class CatResponse {
  @JsonKey(name: "cat_name")
  String? names;
  @JsonKey(name: "cat_des")
  String? des;
  @JsonKey(name: "cat_image_url")
  String? imageUrl;
  @JsonKey(name: "cat_parameter")
  int? parameter;
  CatResponse(this.names, this.des, this.imageUrl, this.parameter);

  factory CatResponse.fromJson(Map<String, dynamic> json) =>
      _$CatResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CatResponseToJson(this);
}
