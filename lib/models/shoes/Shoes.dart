import 'package:cloud_firestore/cloud_firestore.dart';

class Shoes {
  static final CollectionReference<Map<String, dynamic>> collection =
      FirebaseFirestore.instance.collection('shoes');

  final int id;
  final String name;
  final String brand;
  final String price;
  final double quantity;
  final DateTime mfgDate;
  final String origin;
  final String imageURL;
  DocumentReference? reference;

  Shoes({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.quantity,
    required this.mfgDate,
    required this.origin,
    required this.imageURL,
    this.reference,
  });

  //TODO: add json converts
  factory Shoes.fromJson(Map<String, dynamic> json) => Shoes(
        id: json['id'] as int,
        name: json['name'] as String,
        brand: json['brand'] as String,
        price: json['price'] as String,
        quantity: json['quantity'].toDouble(),
        mfgDate: (json['mfgDate'] as Timestamp).toDate(),
        origin: json['origin'] as String,
        imageURL: json['imageURL'] as String,
        reference: json['reference'] as DocumentReference?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'brand': brand,
        'price': price,
        'quantity': quantity,
        'mfgDate': Timestamp.fromDate(mfgDate),
        'origin': origin,
        'imageURL': imageURL,
        'reference': reference,
      };
  //TODO: add from Snapshot
  factory Shoes.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final shoes = Shoes.fromJson(snapshot.data()!);
    shoes.reference = snapshot.reference;
    return shoes;
  }

  static Future<DocumentReference> addShoes({
    required String name,
    required String brand,
    required String price,
    required double quantity,
    required DateTime mfgDate,
    required String origin,
    required String imageURL,
  }) async {
    // Get the next ID
    final QuerySnapshot querySnapshot = await collection.get();
    final int nextId = querySnapshot.size + 1;

    final shoes = Shoes(
      id: nextId,
      name: name,
      brand: brand,
      price: price,
      quantity: quantity,
      mfgDate: mfgDate,
      origin: origin,
      imageURL: imageURL,
    );

    final docRef = await collection.add(shoes.toJson());
    return docRef;
  }
}

