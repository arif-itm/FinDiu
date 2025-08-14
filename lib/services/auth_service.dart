import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart' as AppUser;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Auth state changes stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign in with email and password
  Future<UserCredential?> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Register with email and password
  Future<UserCredential?> registerWithEmailPassword(
    String email, 
    String password, 
    String fullName, {
    String? studentId,
    String? university,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update display name
      await result.user?.updateDisplayName(fullName);

      // Create user document in Firestore
      await _createUserDocument(result.user!, fullName, studentId: studentId, university: university);

      return result;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        throw Exception('Google sign-in was cancelled by user');
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      UserCredential result = await _auth.signInWithCredential(credential);

      // Create user document if it's a new user
      if (result.additionalUserInfo?.isNewUser == true) {
        await _createUserDocument(result.user!, result.user!.displayName ?? 'User');
      }

      return result;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      if (e.toString().contains('cancelled by user')) {
        throw Exception('Google sign-in was cancelled');
      } else if (e.toString().contains('network_error')) {
        throw Exception('Network error during Google sign-in. Please check your internet connection.');
      } else {
        throw Exception('Google sign-in failed. Please try again.');
      }
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      throw Exception('An error occurred during sign out: $e');
    }
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Create user document in Firestore
  Future<void> _createUserDocument(User user, String fullName, {String? studentId, String? university}) async {
    final userDoc = _firestore.collection('users').doc(user.uid);
    
    final userData = AppUser.User(
      id: user.uid,
      name: fullName,
      email: user.email ?? '',
      studentId: studentId ?? '', // Use provided value or empty string
      university: university ?? '', // Use provided value or empty string
      avatar: user.photoURL,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await userDoc.set(userData.toMap());
  }

  // Handle Firebase Auth exceptions
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      // Sign in errors
      case 'user-not-found':
        return 'No account found with this email address. Please check your email or sign up for a new account.';
      case 'wrong-password':
        return 'Incorrect password. Please try again or reset your password.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'user-disabled':
        return 'This account has been disabled. Please contact support for assistance.';
      case 'invalid-credential':
        return 'Invalid email or password. Please check your credentials and try again.';
      
      // Sign up errors
      case 'email-already-in-use':
        return 'An account with this email address already exists. Please sign in instead.';
      case 'weak-password':
        return 'Password is too weak. Please use at least 6 characters with a mix of letters and numbers.';
      
      // Network and service errors
      case 'too-many-requests':
        return 'Too many failed attempts. Please wait a few minutes before trying again.';
      case 'operation-not-allowed':
        return 'This sign-in method is not enabled. Please contact support.';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection and try again.';
      
      // Google Sign-in specific errors
      case 'account-exists-with-different-credential':
        return 'An account already exists with this email using a different sign-in method.';
      case 'popup-closed-by-user':
        return 'Sign-in was cancelled. Please try again.';
      case 'cancelled-popup-request':
        return 'Sign-in was cancelled. Please try again.';
      
      // General errors
      case 'requires-recent-login':
        return 'This operation requires recent authentication. Please sign in again.';
      case 'credential-already-in-use':
        return 'This credential is already associated with a different account.';
      
      default:
        // Log the actual error code for debugging
        print('Unhandled Firebase Auth error: ${e.code} - ${e.message}');
        return 'Authentication failed. Please try again or contact support if the problem persists.';
    }
  }
}
