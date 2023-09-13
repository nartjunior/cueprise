class MemeModel {
  final String url;
  final String name;
  final int width;
  final int height;

  MemeModel(this.url, this.name, this.width, this.height);

  static fromJson(item) {
    return MemeModel(
        item['url'],
        item['name'],
        item['width'],
        item['height']
    );
  }
}