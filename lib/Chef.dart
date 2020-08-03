class Chef {
  final String title;
  final String thumbnailUrl;
  Chef._({this.title, this.thumbnailUrl});
  factory Chef.fromJson(Map<String, dynamic> json) {
    return new Chef._(
      title: json['name'],

    );
  }
}// TODO Implement this library.