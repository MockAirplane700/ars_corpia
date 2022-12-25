import 'package:ars_corpia/objects/marker.dart';

class SearchLogic {
  static List<Marker> markers = [];

  static List<Marker> getMarkers () {
    return markers;
  }

  static void setSearch(List<Marker> list) {
    markers.clear();
    markers.addAll(list);
  }
}