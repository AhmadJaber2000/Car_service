import 'package:meta/meta.dart';

class Item {
  int id;
  String name;
  String category;
  double rating;
  String imageUrl;

  Item({
    required this.id,
    required this.name,
    required this.category,
    required this.rating,
    required this.imageUrl,
  });
}
