import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/user/user_dao.dart';
final userDaoProvider = ChangeNotifierProvider<UserDao>((ref) {
  return UserDao();
});

//TODO: add messageDaoProvider
//TODO: add messageListProvider