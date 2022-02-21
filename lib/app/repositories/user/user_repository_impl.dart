import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../../exception/auth_exception.dart';
import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _auth;

  UserRepositoryImpl({
    required FirebaseAuth auth,
  }) : _auth = auth;

  @override
  Future<User?> register({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return credential.user;
    } on FirebaseAuthException catch (e, s) {
      log('Erro ao registrar', error: e, stackTrace: s);
      if (e.code == 'email-already-exists') {
        final loginTypes = await _auth.fetchSignInMethodsForEmail(email);
        if (loginTypes.contains('password')) {
          throw AuthException(message: 'E-mail já utilizado!');
        } else {
          throw AuthException(message: 'Utilize sua conta Google para entrar.');
        }
      } else {
        throw AuthException(message: 'Erro ao cadastrar usuário');
      }
    }
  }

  @override
  Future<User?> login({required String email, required String password}) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return credential.user;
    } on PlatformException catch (e) {
      throw AuthException(message: e.message ?? 'Erro ao realizar login ');
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: e.message ?? 'Erro ao realizar login ');
    }
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    try {
      final loginTypes = await _auth.fetchSignInMethodsForEmail(email);

      if (loginTypes.contains('password')) {
        await _auth.sendPasswordResetEmail(email: email);
      } else if (loginTypes.contains('Google')) {
        throw AuthException(message: 'Cadastro realizado pelo Google!');
      } else {
        throw AuthException(message: 'E-mail não cadastrado!');
      }
    } on PlatformException catch (e) {
      print(e);
      throw AuthException(message: 'Erro ao resetar senha');
    }
  }
}
