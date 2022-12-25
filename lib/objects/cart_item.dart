import 'package:ars_corpia/constants/functions.dart';
import 'package:ars_corpia/objects/marker.dart';

class CartItem {
  final int id;
  final Marker marker;
  final int quantity;
  final String total;

  CartItem({
    required this.id,required this.marker,
    required this.quantity,required this.total
});

  Map<String,dynamic> toJson() {
    return {
      'id' : id,
      'name' : marker.name,
      'description':marker.description,
      'images':getString(marker.images),
      'price':marker.price,
      'link':marker.link,
      'quantity': quantity,
      'total' : total
    };
  }
}