class Image {
  final String path;
  final String name;
  final String type;
  final int size;
  final String mime;
  final Object meta;
  final String url;

  Image({
    required this.path,
    required this.name,
    required this.type,
    required this.size,
    required this.mime,
    required this.meta,
    required this.url,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      path: json["path"],
      name: json["name"],
      type: json["type"],
      size: json["size"],
      mime: json["mime"],
      meta: json["meta"],
      url: json["url"],
    );
  }
}
