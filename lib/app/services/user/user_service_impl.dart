import 'package:firebase_auth/firebase_auth.dart';

import '../../repositories/user/user_repository.dart';
import './user_service.dart';

class UserServiceImpl implements UserService {
  final UserRepository _repository;

  UserServiceImpl({
    required UserRepository repository,
  }) : _repository = repository;

  @override
  Future<User?> register({required String email, required String password}) =>
      _repository.register(email: email, password: password);
}
