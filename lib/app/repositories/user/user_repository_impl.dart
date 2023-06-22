import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../exception/auth_exception.dart';
import 'user_repository.dart';

final class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _auth;

  const UserRepositoryImpl({required FirebaseAuth auth}) : _auth = auth;

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
          Error.throwWithStackTrace(
            const AuthException(message: 'E-mail já utilizado!'),
            s,
          );
        } else {
          Error.throwWithStackTrace(
            const AuthException(
              message: 'Utilize sua conta Google para entrar.',
            ),
            s,
          );
        }
      } else {
        Error.throwWithStackTrace(
          const AuthException(message: 'Erro ao cadastrar usuário'),
          s,
        );
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
    } on PlatformException catch (e, s) {
      Error.throwWithStackTrace(
        AuthException(message: e.message ?? 'Erro ao realizar login '),
        s,
      );
    } on FirebaseAuthException catch (e, s) {
      Error.throwWithStackTrace(
        AuthException(message: e.message ?? 'Erro ao realizar login '),
        s,
      );
    }
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    try {
      final loginTypes = await _auth.fetchSignInMethodsForEmail(email);

      if (loginTypes.contains('password')) {
        await _auth.sendPasswordResetEmail(email: email);
      } else if (loginTypes.contains('Google')) {
        throw const AuthException(message: 'Cadastro realizado pelo Google!');
      } else {
        throw const AuthException(message: 'E-mail não cadastrado!');
      }
    } on PlatformException catch (_, s) {
      Error.throwWithStackTrace(
        const AuthException(message: 'Erro ao resetar senha'),
        s,
      );
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
          throw const AuthException(
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
    } on FirebaseException catch (e, s) {
      Error.throwWithStackTrace(
        AuthException(message: e.message ?? 'Erro interno'),
        s,
      );
    }

    return null;
  }

  @override
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      _auth.signOut();
    } on Exception {
      _auth.signOut();
    }
  }

  @override
  Future<void> updateDisplayName({required String name}) async {
    final user = _auth.currentUser;

    if (user != null) {
      await user.updateDisplayName(name);
      user.reload();
    }
  }
}
