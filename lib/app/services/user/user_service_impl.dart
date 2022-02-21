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

  @override
  Future<User?> login({required String email, required String password}) =>
      _repository.login(email: email, password: password);

  @override
  Future<void> forgotPassword({required String email}) =>
      _repository.forgotPassword(email: email);

  @override
  Future<User?> googleLogin() => _repository.googleLogin();

  @override
  Future<void> logout() => _repository.logout();

  @override
  Future<void> updateDisplayName({required String name}) =>
      _repository.updateDisplayName(name: name);
}
