// To parse this JSON data, do
//
//     final influencerTransactionsModel = influencerTransactionsModelFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators, prefer_null_aware_operators

import 'dart:convert';

TrendingsModel trendingsModelFromJson(String str) => TrendingsModel.fromJson(json.decode(str));

String trendingsModelToJson(TrendingsModel data) => json.encode(data.toJson());

class TrendingsModel {
  TrendingsModel({
    this.locale,
    this.results,
    this.next,
  });

  final String? locale;
  final List<Result>? results;
  final String? next;

  factory TrendingsModel.fromJson(Map<String, dynamic> json) => TrendingsModel(
        locale: json["locale"] == null ? null : json["locale"],
        results: json["results"] == null ? null : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        next: json["next"] == null ? null : json["next"],
      );

  Map<String, dynamic> toJson() => {
        "locale": locale == null ? null : locale,
        "results": results == null ? null : List<dynamic>.from(results!.map((x) => x.toJson())),
        "next": next == null ? null : next,
      };
}

class Result {
  Result({
    this.id,
    this.title,
    this.contentDescription,
    this.contentRating,
    this.h1Title,
    this.media,
    this.bgColor,
    this.created,
    this.itemurl,
    this.url,
    this.tags,
    this.flags,
    this.shares,
    this.hasaudio,
    this.hascaption,
    this.sourceId,
    this.composite,
  });

  final String? id;
  final String? title;
  final String? contentDescription;
  final String? contentRating;
  final String? h1Title;
  final List<Map<String, Media>>? media;
  final String? bgColor;
  final double? created;
  final String? itemurl;
  final String? url;
  final List<dynamic>? tags;
  final List<dynamic>? flags;
  final int? shares;
  final bool? hasaudio;
  final bool? hascaption;
  final String? sourceId;
  final dynamic composite;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        contentDescription: json["content_description"] == null ? null : json["content_description"],
        contentRating: json["content_rating"] == null ? null : json["content_rating"],
        h1Title: json["h1_title"] == null ? null : json["h1_title"],
        media: json["media"] == null
            ? null
            : List<Map<String, Media>>.from(json["media"].map((x) => Map.from(x).map((k, v) => MapEntry<String, Media>(k, Media.fromJson(v))))),
        bgColor: json["bg_color"] == null ? null : json["bg_color"],
        created: json["created"] == null ? null : json["created"].toDouble(),
        itemurl: json["itemurl"] == null ? null : json["itemurl"],
        url: json["url"] == null ? null : json["url"],
        tags: json["tags"] == null ? null : List<dynamic>.from(json["tags"].map((x) => x)),
        flags: json["flags"] == null ? null : List<dynamic>.from(json["flags"].map((x) => x)),
        shares: json["shares"] == null ? null : json["shares"],
        hasaudio: json["hasaudio"] == null ? null : json["hasaudio"],
        hascaption: json["hascaption"] == null ? null : json["hascaption"],
        sourceId: json["source_id"] == null ? null : json["source_id"],
        composite: json["composite"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "content_description": contentDescription == null ? null : contentDescription,
        "content_rating": contentRating == null ? null : contentRating,
        "h1_title": h1Title == null ? null : h1Title,
        "media": media == null ? null : List<dynamic>.from(media!.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())))),
        "bg_color": bgColor == null ? null : bgColor,
        "created": created == null ? null : created,
        "itemurl": itemurl == null ? null : itemurl,
        "url": url == null ? null : url,
        "tags": tags == null ? null : List<dynamic>.from(tags!.map((x) => x)),
        "flags": flags == null ? null : List<dynamic>.from(flags!.map((x) => x)),
        "shares": shares == null ? null : shares,
        "hasaudio": hasaudio == null ? null : hasaudio,
        "hascaption": hascaption == null ? null : hascaption,
        "source_id": sourceId == null ? null : sourceId,
        "composite": composite,
      };
}

class Media {
  Media({
    this.preview,
    this.dims,
    this.url,
    this.size,
    this.duration,
  });

  final String? preview;
  final List<int>? dims;
  final String? url;
  final int? size;
  final double? duration;

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        preview: json["preview"] == null ? null : json["preview"],
        dims: json["dims"] == null ? null : List<int>.from(json["dims"].map((x) => x)),
        url: json["url"] == null ? null : json["url"],
        size: json["size"] == null ? null : json["size"],
        duration: json["duration"] == null ? null : json["duration"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "preview": preview == null ? null : preview,
        "dims": dims == null ? null : List<dynamic>.from(dims!.map((x) => x)),
        "url": url == null ? null : url,
        "size": size == null ? null : size,
        "duration": duration == null ? null : duration,
      };
}
