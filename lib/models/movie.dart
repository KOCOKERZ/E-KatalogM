class Movie {
  String title;
  String backDropPath;
  String orignalTitle;
  String overview;
  String posterPath;
  String releaseDate;
  double voteAverage;

  // Properti tambahan untuk tampilan databaseurl
  String judul;
  String genre;
  String sinopsis;
  String penulis;
  String sutradara;
  String aktor;


  Movie({
    required this.title,
    required this.backDropPath,
    required this.orignalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    // Inisialisasi properti tambahan
    required this.judul,
    required this.genre,
    required this.sinopsis,
    required this.penulis,
    required this.sutradara,
    required this.aktor,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json["title"],
      backDropPath: json["backdrop_path"],
      orignalTitle: json["original_title"],
      overview: json["overview"],
      posterPath: json["poster_path"],
      releaseDate: json["release_date"],
      voteAverage: json["vote_average"].toDouble(),
      // Inisialisasi properti tambahan dari tampilan databaseurl
      judul: json["Judul"],
      genre: json["Genre"],
      sinopsis: json["Sinopsis"],
      penulis: json["Penulis"],
      sutradara: json["Sutradara"],
      aktor: json["Aktor"],
    );
  }
}
