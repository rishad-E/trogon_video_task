// To parse this JSON data, do
//
//     final videoModel = videoModelFromJson(jsonString);

// import 'dart:convert';

// List<VideoModel> videoModelFromJson(String str) => List<VideoModel>.from(json.decode(str).map((x) => VideoModel.fromJson(x)));

// String videoModelToJson(List<VideoModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// ignore_for_file: constant_identifier_names

class VideoModel {
    int? id;
    String? title;
    String? description;
    VideoType? videoType;
    String? videoUrl;

    VideoModel({
        this.id,
        this.title,
        this.description,
        this.videoType,
        this.videoUrl,
    });

    factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        videoType: videoTypeValues.map[json["video_type"]]!,
        videoUrl: json["video_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "video_type": videoTypeValues.reverse[videoType],
        "video_url": videoUrl,
    };
}

enum VideoType {
    VIMEO,
    YOU_TUBE
}

final videoTypeValues = EnumValues({
    "Vimeo": VideoType.VIMEO,
    "YouTube": VideoType.YOU_TUBE
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
