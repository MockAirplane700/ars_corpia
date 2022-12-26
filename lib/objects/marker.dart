class Marker {
  final String name;
  final String description;
  final List<dynamic> images;
  final double price;
  final String link;
  final String asin;

  Marker({
    required this.name, required this.description,
    required this.images, required this.price,
    required this.link, required this.asin
});

  void add(List<String> list){
    images.clear();
    images.addAll(list);
  }

}