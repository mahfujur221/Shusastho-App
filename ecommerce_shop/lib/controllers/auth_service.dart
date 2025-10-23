import 'package:ecommerce_shop/controllers/db_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Create new account using email and password method
  Future<String> createAccountWithEmail(String name, String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      if (user != null) {
        // Ensure auth state is synced before accessing Firestore
        await FirebaseAuth.instance.authStateChanges().first;

        // Save user data in Firestore
        await DbService().saveUserData(uid: user.uid, name: name, email: email);
        return "Account Created";
      } else {
        return "Account creation failed";
      }
    } on FirebaseAuthException catch (e) {
      return e.message ?? "An error occurred";
    } catch (e) {
      return "An unexpected error occurred: $e";
    }
  }

  // Login with email and password method
  Future<String> loginWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return "Login Successful";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  // Logout the user
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  // Reset the password
  Future<String> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return "Mail Sent";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  // Check whether the user is signed in or not
  Future<bool> isLoggedIn() async {
    var user = FirebaseAuth.instance.currentUser;
    return user != null;
  }
}
