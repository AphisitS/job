// To parse this JSON data, do
//
//     final dataModels = dataModelsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<DataModels> dataModelsFromJson(String str) => List<DataModels>.from(json.decode(str).map((x) => DataModels.fromJson(x)));

String dataModelsToJson(List<DataModels> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DataModels {
  DataModels({
    @required this.iconUrl,
    @required this.titleName,
    @required this.value,
    @required this.desireable,
    @required this.target,
    @required this.different,
  });

  String iconUrl;
  String titleName;
  String value;
  String desireable;
  dynamic target;
  dynamic different;

  factory DataModels.fromJson(Map<String, dynamic> json) => DataModels(
    iconUrl: json["iconUrl"],
    titleName: json["titleName"],
    value: json["value"],
    desireable: json["desireable"],
    target: json["target"],
    different: json["different"],
  );

  Map<String, dynamic> toJson() => {
    "iconUrl": iconUrl,
    "titleName": titleName,
    "value": value,
    "desireable": desireable,
    "target": target,
    "different": different,
  };
}
