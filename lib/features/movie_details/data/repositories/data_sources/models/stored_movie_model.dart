class StoredMovieModel {
  String id;
  int movieId;
  double rating;
  String coverImage;
  String movieName;

  StoredMovieModel(this.rating, this.coverImage, this.id,this.movieId,this.movieName);

  factory StoredMovieModel.fromJson(Map<String, dynamic> json) {
    return StoredMovieModel(
      json['rating'],
      json['cover_image'],
      json['id'],
      json['movie_id'],
      json['name'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'movie_id':movieId,
      'name':movieName,
      'rating': rating,
      'cover_image': coverImage,
    };
  }
}