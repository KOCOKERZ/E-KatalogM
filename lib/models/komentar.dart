import 'package:movieproject/api/api_komentar.dart';

class Comment {
  final String id;
  final String idFilm;
  final String name;
  final String tanggal;
  final String komentar;

  Comment({
    required this.id,
    required this.idFilm,
    required this.name,
    required this.tanggal,
    required this.komentar,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['ID'],
      idFilm: json['ID_FILM'],
      name: json['Name'],
      tanggal: json['Tanggal'],
      komentar: json['Komentar'],
    );
  }
}