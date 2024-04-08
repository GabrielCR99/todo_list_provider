import 'package:firebase_auth/firebase_auth.dart';

import '../../repositories/user/user_repository.dart';
import 'user_service.dart';

final class UserServiceImpl implements UserService {
  final UserRepository repository;

  const UserServiceImpl({required this.repository});

  @override
  Future<User?> register({required String email, required String password}) =>
      repository.register(email: email, password: password);

  @override
  Future<User?> login({required String email, required String password}) =>
      repository.login(email: email, password: password);

  @override
  Future<void> forgotPassword({required String email}) =>
      repository.forgotPassword(email: email);

  @override
  Future<User?> googleLogin() => repository.googleLogin();

  @override
  Future<void> logout() => repository.logout();

  @override
  Future<void> updateDisplayName({required String name}) =>
      repository.updateDisplayName(name: name);
}
