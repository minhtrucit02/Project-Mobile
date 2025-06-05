import 'package:cloud_firestore/cloud_firestore.dart';

class ImageDetail {
  ImageDetail({required this.imagePath});

  final String imagePath;

  factory ImageDetail.fromJson(Map<String, dynamic> json) =>
      ImageDetail(imagePath: json['imagePath']);

  Map<String, dynamic> toJson() => {'imagePath': imagePath};
}
