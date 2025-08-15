import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class FirebaseService {
  static FirebaseAuth get auth => FirebaseAuth.instance;
  static FirebaseFirestore get firestore => FirebaseFirestore.instance;
  // Hint account picker to DIU domain; still enforce in AuthService.
  // Provide clientId on web if this getter is ever used for web contexts.
  static GoogleSignIn get googleSignIn => GoogleSignIn(
    hostedDomain: 'diu.edu.bd',
  scopes: const <String>['email'],
    clientId: kIsWeb
    ? '802298935416-jpgj0r49r0q5g5h0jjt188pgb6prm21l.apps.googleusercontent.com'
    : null,
  );

  // Initialize Firebase
  static Future<void> initialize() async {
    await Firebase.initializeApp();
  }

  // Check if user is authenticated
  static User? get currentUser => auth.currentUser;
  static bool get isAuthenticated => currentUser != null;

  // Stream of authentication state changes
  static Stream<User?> get authStateChanges => auth.authStateChanges();
}
