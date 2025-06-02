import 'package:chat_application/Services/user_repository_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';

final userRepositoryProvider = Provider((ref) => UserRepository());

final allUsersProvider = StreamProvider<List<UserModel>>((ref) {
  return ref.read(userRepositoryProvider).getAllUsers();
});
