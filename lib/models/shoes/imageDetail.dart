import 'package:cloud_firestore/cloud_firestore.dart';

class ImageDetail {
  ImageDetail({
    required this.id,
    required this.productDetailID,
    required this.imageDetail,
  });
  final int id;
  final int productDetailID;
  final String imageDetail;

  factory ImageDetail.fromJson(Map<String, dynamic> json) => ImageDetail(
    id: json['id'],
    productDetailID: json['productDetailId'],
    imageDetail: json['imageDetail'],
  );
  Map<String, dynamic> toJson() => {
    'id':id,
    'productDetailId':productDetailID,
    'imageDetail': imageDetail,
  };

}