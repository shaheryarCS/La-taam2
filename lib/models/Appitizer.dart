class Appitizer {
   String title;
   String thumbnailUrl;
  Appitizer._({this.title, this.thumbnailUrl});
  factory Appitizer.fromJson(Map<String, dynamic> json) {
    return new Appitizer._(
      title: json['name'],

    );
  }
}// TODO Implement this library.