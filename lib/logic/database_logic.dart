import 'package:ars_corpia/objects/cart_item.dart';
import 'package:ars_corpia/persistence/database.dart';

class DatabaseLogic {
  static Future getMarkers () async {
    return DatabaseManager.fakePersistenceMarkers();
  }

  static Future addMarker(CartItem item) async {
    return DatabaseManager.insertItem(item);
  }

  static Future getHistory() async {
    return DatabaseManager.getItems();
  }

  static Future getMarkerReviews() async {
    return DatabaseManager.fakePersistenceReviews();
  }

  static Future getAbouts() async {
    return DatabaseManager.fakePersistenceAboutReviewers();
  }
}