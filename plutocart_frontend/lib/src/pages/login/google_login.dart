import 'package:google_sign_in/google_sign_in.dart';

const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

class GoogleSignInService {
  static GoogleSignIn _googleSignIn = GoogleSignIn(
    // clientId: '232792221897-6n5d0jvhfpeacnq16s630arh3rs4k5qn.apps.googleusercontent.com',
    scopes: scopes,
  );

  static Future<void> handleSignIn() async {
    handleSignOut();
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        print("email: ${googleUser.email}");
        print("username : ${googleUser.displayName}");
        // Use 'googleUser' to access user information like display name, email, etc.
      }
    } catch (error) {
      print('Error signing in: $error');
    }
  }

  static Future<void> handleSignOut() async {
    try {
      await _googleSignIn.disconnect();
    } catch (error) {
      print(error);
    }
  }
}
