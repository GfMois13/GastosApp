// ignore: unused_import
import 'package:flutter/material.dart';
// ignore: unused_import
// ignore: import_of_legacy_library_into_null_safe
import 'package:gastos/views/HomePage.dart';
// ignore: unused_import
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;

  AuthService(this._firebaseAuth);

  Stream<User> get authStateChanges =>
      _firebaseAuth.authStateChanges() as Stream<User>;

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Sesión Iniciada";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> signUp(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Usuario creado";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
