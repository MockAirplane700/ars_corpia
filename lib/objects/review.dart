import 'package:ars_corpia/objects/marker.dart';

class Review{
  final String? youtube;
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

// /Pods/OrderedSet/Sources/OrderedSet.swift'
// xattr: [Errno 13] Permission denied: './Pods/FMDB/src/fmdb/FMDatabase.h'
// xattr: [Errno 13] Permission denied: './Pods/FMDB/src/fmdb/FMDatabaseQueue.m'
// xattr: [Errno 13] Permission denied: './Pods/FMDB/src/fmdb/FMResultSet.h'
// xattr: [Errno 13] Permission denied: './Pods/FMDB/src/fmdb/FMDatabasePool.h'
// xattr: [Errno 13] Permission denied: './Pods/FMDB/src/fmdb/FMDatabaseAdditions.m'
// xattr: [Errno 13] Permission denied: './Pods/FMDB/src/fmdb/FMDatabase.m'
// xattr: [Errno 13] Permission denied: './Pods/FMDB/src/fmdb/FMDatabaseQueue.h'
// xattr: [Errno 13] Permission denied: './Pods/FMDB/src/fmdb/FMDB.h'
