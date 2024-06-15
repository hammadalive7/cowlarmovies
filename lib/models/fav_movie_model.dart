class FavMovie {
  final int id;
  final String title;
  final String posterPath;

  FavMovie({
    required this.id,
    required this.title,
    required this.posterPath,
  });

  // Convert a Movie object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'posterPath': posterPath,
    };
  }

  // Extract a Movie object from a Map object
  factory FavMovie.fromMap(Map<String, dynamic> map) {
    return FavMovie(
      id: map['id'],
      title: map['title'],
      posterPath: map['posterPath'],
    );
  }
}
