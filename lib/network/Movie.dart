import 'dart:convert';

List<Movie> movieModelFromJson(String str) =>
    List<Movie>.from(
        json.decode(str).map((x) => Movie.fromJson(x)));

String movieModelToJson(List<Movie> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Movie {
    Movie({
        required this.id,
        required this.title,
        required this.releaseDate,
        required this.posterPath
    });

    final int id;
    final String title;
    final String releaseDate;
    final String posterPath;

    factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json["id"] as int,
        title: json["original_title"] as String,
        releaseDate: json["release_date"] as String,
        posterPath: json["poster_path"] as String
    );

    Map<String, dynamic> toJson() => {
      "id": id,
      "original_title": title,
      "release_date": releaseDate,
      "poster_path": posterPath
    };
}
