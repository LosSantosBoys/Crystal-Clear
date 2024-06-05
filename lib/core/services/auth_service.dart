import 'package:crystalclear/core/enum/service_status.dart';
import 'package:crystalclear/core/models/service_return.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FlutterSecureStorage storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  Future<ServiceReturn> createAccount({required String name, required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await _auth.currentUser!.updateDisplayName(name);

      if (await _auth.currentUser!.getIdToken() == null) {
        return ServiceReturn(status: ServiceStatus.error, message: 'Erro ao criar uma conta com e-mail e senha. Tente novamente mais tarde.');
      }

      await storage.write(key: 'token', value: await _auth.currentUser!.getIdToken());
      await storage.write(key: 'uid', value: _auth.currentUser!.uid);

      return ServiceReturn(status: ServiceStatus.success);
    } on FirebaseAuthException catch (error) {
      return ServiceReturn(status: ServiceStatus.error, message: error.message);
    }
  }

  Future<ServiceReturn> deleteAccount() async {
    try {
      await _auth.currentUser!.delete();
      await storage.deleteAll();

      return ServiceReturn(status: ServiceStatus.success);
    } on FirebaseAuthException catch (error) {
      return ServiceReturn(status: ServiceStatus.error, message: error.message);
    }
  }

  Future<ServiceReturn> login({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      if (await _auth.currentUser!.getIdToken() == null) {
        return ServiceReturn(status: ServiceStatus.error, message: 'Erro ao fazer login com e-mail e senha. Tente novamente mais tarde.');
      }

      await storage.write(key: 'token', value: await _auth.currentUser!.getIdToken());
      await storage.write(key: 'uid', value: _auth.currentUser!.uid);

      return ServiceReturn(status: ServiceStatus.success);
    } on FirebaseAuthException catch (error) {
      return ServiceReturn(status: ServiceStatus.error, message: error.message);
    }
  }

  Future<ServiceReturn> logout() async {
    try {
      await _auth.signOut();
      await storage.deleteAll();

      return ServiceReturn(status: ServiceStatus.success);
    } on FirebaseAuthException catch (error) {
      return ServiceReturn(status: ServiceStatus.error, message: error.message);
    }
  }

  Future<ServiceReturn> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);

      return ServiceReturn(status: ServiceStatus.success);
    } on FirebaseAuthException catch (error) {
      return ServiceReturn(status: ServiceStatus.error, message: error.message);
    }
  }

  Future<ServiceReturn> updatePassword({required String password}) async {
    try {
      await _auth.currentUser!.updatePassword(password);

      return ServiceReturn(status: ServiceStatus.success);
    } on FirebaseAuthException catch (error) {
      return ServiceReturn(status: ServiceStatus.error, message: error.message);
    }
  }

  Future<ServiceReturn> updateProfile({required String displayName}) async {
    try {
      await _auth.currentUser!.updateDisplayName(displayName);

      return ServiceReturn(status: ServiceStatus.success);
    } on FirebaseAuthException catch (error) {
      return ServiceReturn(status: ServiceStatus.error, message: error.message);
    }
  }

  Future<ServiceReturn> verifyEmail() async {
    try {
      await _auth.currentUser!.sendEmailVerification();

      return ServiceReturn(status: ServiceStatus.success);
    } on FirebaseAuthException catch (error) {
      return ServiceReturn(status: ServiceStatus.error, message: error.message);
    }
  }

  Future<ServiceReturn> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);

      if (await _auth.currentUser!.getIdToken() == null) {
        return ServiceReturn(status: ServiceStatus.error, message: 'Erro ao fazer login com o Google. Tente novamente mais tarde.');
      }

      await storage.write(key: 'token', value: await _auth.currentUser!.getIdToken());
      await storage.write(key: 'uid', value: _auth.currentUser!.uid);

      return ServiceReturn(status: ServiceStatus.success);
    } on FirebaseAuthException catch (error) {
      return ServiceReturn(status: ServiceStatus.error, message: error.message);
    }
  }

  User? getUser() {
    return _auth.currentUser;
  }

  Future<bool> isAuthenticated() async {
    try {
      if (getUser() == null) {
        return false;
      }

      return await _auth.currentUser!.getIdToken() != null;
    } catch (e) {
      return false;
    }
  }

  Future<String?> getToken() async {
    try {
      final User? currentUser = _auth.currentUser;

      if (currentUser == null) {
        return null;
      }

      return await currentUser.getIdToken();
    } catch (e) {
      if (kDebugMode) {
        print('AuthService.getToken: $e');
      }

      return null;
    }
  }
}
