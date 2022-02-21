import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
    } on PlatformException {
      throw AuthException(message: 'Erro ao resetar senha');
    }
  }

  @override
  Future<User?> googleLogin() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        final loginTypes =
            await _auth.fetchSignInMethodsForEmail(googleUser.email);

        if (loginTypes.contains('password')) {
          throw AuthException(
            message: 'Você utilizou o email para cadastro no app.',
          );
        } else {
          final googleAuth = await googleUser.authentication;
          final firebaseCredential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
          final userCredential =
              await _auth.signInWithCredential(firebaseCredential);

          return userCredential.user;
        }
      }
    } on FirebaseException catch (e) {
      throw AuthException(message: e.message ?? 'Erro interno');
    }

    return null;
  }

  @override
  Future<void> logout() async {
    await GoogleSignIn().signOut();
    _auth.signOut();
  }
}
