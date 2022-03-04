import 'dart:convert';

List<MovieModel> productsModelFromJson(String str) =>
    List<MovieModel>.from(
        json.decode(str).map((x) => MovieModel.fromJson(x)));

String productsModelToJson(List<MovieModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MovieModel {
    MovieModel({
        this.id,
        this.title,
        this.releaseDate,
        this.posterPath
    });

    final int? id;
    final String? title;
    final String? releaseDate;
    final String? posterPath;

    factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        id: json["id"],
        title: json["original_title"],
        releaseDate: json["release_date"],
        posterPath: json["poster_path"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "original_title": title,
        "release_date": releaseDate,
        "poster_path": posterPath
      };
}