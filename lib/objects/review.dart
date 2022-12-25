import 'package:ars_corpia/objects/marker.dart';

class Review{
  final String youtube;
  final List<Marker> markers;
  final String name;
  final String description;
  final String image;
  final List<String> sponsorNames;
  final List<String> sponsorCodes;

  Review({required this.youtube, required this.markers, required this.name,
  required this.description, required this.image, required this.sponsorNames,
  required this.sponsorCodes});
}