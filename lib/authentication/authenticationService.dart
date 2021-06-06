import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  final FirebaseAuth _auth;

  AuthenticationService() : _auth = FirebaseAuth.instance;

  Stream<User?> get userChanges => _auth.userChanges();

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<AuthenticationResult<User?>> signInGoogle() async {
    try {
      final gUser = await GoogleSignIn().signIn();
      if (gUser == null) return AuthenticationResult.cancelled();
      final auth = await gUser.authentication;
      final credential = GoogleAuthProvider.credential(
          idToken: auth.idToken, accessToken: auth.accessToken);
      final result = await _auth.signInWithCredential(credential);
      return AuthenticationResult(result.user);
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'account-exists-with-different-credential':
          errorMessage = 'Email already in use';
          break;
        case 'invalid-credential':
          errorMessage = 'The credential is malformed or has expired';
          break;
        case 'user-disabled':
          errorMessage = 'This account has been disabled';
          break;
        case 'user-not-found':
          errorMessage =
              'There are no accounts registered with this email address';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong Password';
          break;
        case 'invalid-verification-code':
        case 'invalid-verification-id':
        case 'operation-not-allowed':
        default:
          errorMessage = 'Could not sign you in';
      }
      return AuthenticationResult.withError(errorMessage);
    }
  }

  Future<AuthenticationResult<User?>> signInEmail(
      String email, String password) async {
    try {
      var cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return AuthenticationResult(cred.user);
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'Invalid Email';
          break;
        case 'user-disabled':
          errorMessage = 'This account has been disabled';
          break;
        case 'user-not-found':
          errorMessage =
              'There are no accounts registered with this email address';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong Password';
          break;
        default:
          errorMessage = 'Could not sign you in';
      }
      return AuthenticationResult.withError(errorMessage);
    }
  }

  Future<AuthenticationResult<User?>> signInAnonymous() async {
    try {
      var cred = await _auth.signInAnonymously();
      return AuthenticationResult(cred.user);
    } on FirebaseAuthException {
      return AuthenticationResult.withError('Could not sign you in');
    }
  }

  Future<AuthenticationResult<User?>> signUpEmail(
      String email, String password) async {
    try {
      var cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return AuthenticationResult(cred.user);
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'This email is already in use';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid Email';
          break;
        case 'weak-password':
          errorMessage = 'Password too weak';
          break;
        case 'operation-not-allowed':
        default:
          errorMessage = 'Could not sign you up';
      }
      return AuthenticationResult.withError(errorMessage);
    }
  }

  Future<AuthenticationResult> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return AuthenticationResult(null);
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'auth/invalid-email':
          errorMessage = 'Invalid Email';
          break;
        case 'auth/user-not-found':
          errorMessage =
              'There are no accounts registered with this email address';
          break;
        case 'auth/missing-android-pkg-name':
        case 'auth/missing-continue-uri':
        case 'auth/missing-ios-bundle-id':
        case 'auth/invalid-continue-uri':
        case 'auth/unauthorized-continue-uri':
        default:
          errorMessage = 'Could not send a password reset email';
      }
      return AuthenticationResult.withError(errorMessage);
    }
  }

  Future<AuthenticationResult> confirmPasswordReset(
      String code, String newPassword) async {
    try {
      await _auth.confirmPasswordReset(code: code, newPassword: newPassword);
      return AuthenticationResult(null);
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'expired-action-code':
          errorMessage = 'Action code expired';
          break;
        case 'invalid-action-code':
          errorMessage = 'Invalid action code';
          break;
        case 'user-disabled':
          errorMessage = 'This account has been disabled';
          break;
        case 'user-not-found':
          errorMessage =
              'There are no accounts registered with this email address';
          break;
        case 'weak-password':
          errorMessage = 'Password too weak';
          break;
        default:
          errorMessage = 'Could not reset password';
      }
      return AuthenticationResult.withError(errorMessage);
    }
  }

  Future signOut() async => await _auth.signOut();
}

class AuthenticationResult<T> {
  T? _val;
  String? _errorMesage;
  bool _cancelled = false;

  AuthenticationResult.withError(String errorMessage)
      : _val = null,
        _errorMesage = errorMessage;

  AuthenticationResult(T? val) {
    _val = val;
    if (val == null) _errorMesage = 'Server error';
  }

  AuthenticationResult.cancelled() : _cancelled = true;

  T? get val => _val;
  String? get errorMessage => _errorMesage;
  bool get hasError => _errorMesage != null;
  bool get cancelled => _cancelled;
}
