// To parse this JSON data, do
//
//     final featuredModel = featuredModelFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

FeaturedModel featuredModelFromJson(String str) => FeaturedModel.fromJson(json.decode(str));

String featuredModelToJson(FeaturedModel data) => json.encode(data.toJson());

class FeaturedModel {
  FeaturedModel({
    this.locale,
    this.tags,
  });

  final String? locale;
  final List<Tag>? tags;

  factory FeaturedModel.fromJson(Map<String, dynamic> json) => FeaturedModel(
        locale: json["locale"] == null ? null : json["locale"],
        tags: json["tags"] == null ? null : List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "locale": locale == null ? null : locale,
        "tags": tags == null ? null : List<dynamic>.from(tags!.map((x) => x.toJson())),
      };
}

class Tag {
  Tag({
    this.searchItem,
    this.path,
    this.image,
    this.name,
    this.type,
  });

  final String? searchItem;
  final String? path;
  final String? image;
  final String? name;
  final String? type;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        searchItem: json["searchterm"] == null ? null : json["searchterm"],
        path: json["path"] == null ? null : json["path"],
        image: json["image"] == null ? null : json["image"],
        name: json["name"] == null ? null : json["name"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toJson() => {
        "searchterm": searchItem == null ? null : searchItem,
        "path": path == null ? null : path,
        "image": image == null ? null : image,
        "name": name == null ? null : name,
        "type": type == null ? null : type,
      };
}
