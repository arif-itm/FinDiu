import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  static FirebaseAuth get auth => FirebaseAuth.instance;
  static FirebaseFirestore get firestore => FirebaseFirestore.instance;
  static GoogleSignIn get googleSignIn => GoogleSignIn();

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
