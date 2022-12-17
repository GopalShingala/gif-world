// To parse this JSON data, do
//
//     final exploreModel = exploreModelFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

ExploreModel exploreModelFromJson(String str) => ExploreModel.fromJson(json.decode(str));

String exploreModelToJson(ExploreModel data) => json.encode(data.toJson());

class ExploreModel {
  ExploreModel({
    this.tags,
  });

  final List<ExploreTagModel>? tags;

  factory ExploreModel.fromJson(Map<String, dynamic> json) => ExploreModel(
        tags: json["tags"] == null ? null : List<ExploreTagModel>.from(json["tags"].map((x) => ExploreTagModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tags": tags == null ? null : List<dynamic>.from(tags!.map((x) => x.toJson())),
      };
}

class ExploreTagModel {
  ExploreTagModel({
    this.searchterm,
    this.path,
    this.image,
    this.name,
    this.type,
  });

  final String? searchterm;
  final String? path;
  final String? image;
  final String? name;
  final String? type;

  factory ExploreTagModel.fromJson(Map<String, dynamic> json) => ExploreTagModel(
        searchterm: json["searchterm"] == null ? null : json["searchterm"],
        path: json["path"] == null ? null : json["path"],
        image: json["image"] == null ? null : json["image"],
        name: json["name"] == null ? null : json["name"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toJson() => {
        "searchterm": searchterm == null ? null : searchterm,
        "path": path == null ? null : path,
        "image": image == null ? null : image,
        "name": name == null ? null : name,
        "type": type == null ? null : type,
      };
}
