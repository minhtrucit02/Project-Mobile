class User{
  User({
  required this.id,
  required this.name,
  required this.email,
  required this.address,
  required this.phone,
  required this.cardId,
  required this.dateCreateUser
  });
  final int id;
  final String name;
  final String email;
  final String address;
  final String phone;
  final int cardId;
  final DateTime dateCreateUser;
}
