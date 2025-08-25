import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class GoogleAuthService {
  // final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  // bool _isGoogleSignInInitialized = false;
  // static final scopes = ['openid', 'email'];
  // static final String googleWebClientId =
  //     "974133795038-2klsneg3ncgt472e6jv6trkiobcg8nuo.apps.googleusercontent.com";
  // static final String googleClientId =
  //     "974133795038-74q4o91k634sbqjio5h26pvhgodlvtd6.apps.googleusercontent.com";

  // GoogleAuthService() {
  //   _initializeGoogleSignIn();
  // }

  // Future<void> _initializeGoogleSignIn() async {
  //   try {
  //     await _googleSignIn.initialize(serverClientId: googleClientId);
  //     _isGoogleSignInInitialized = true;
  //   } catch (e) {
  //     SmartDialog.showToast("初始化Google登录失败: ${e.toString()}");
  //     print('---Failed to initialize Google Sign-In: $e');
  //   }
  // }

  // Future<void> _ensureGoogleSignInInitialized() async {
  //   if (!_isGoogleSignInInitialized) {
  //     await _initializeGoogleSignIn();
  //   }
  // }

  // Future<GoogleSignInAccount?> signInWithGoogle() async {
  //   await _ensureGoogleSignInInitialized();

  //   try {
  //     final GoogleSignInAccount account = await _googleSignIn.authenticate(
  //       scopeHint: scopes, // Specify required scopes
  //     );
  //     return account;
  //   } on GoogleSignInException catch (e) {
  //     final String errorMessage =
  //         'Google Sign In error: code: ${e.code.name} description:${e.description} details:${e.details}';
  //     print(errorMessage);
  //     SmartDialog.showToast("Google登录失败: $errorMessage");
  //     rethrow;
  //   } catch (error) {
  //     print('Unexpected Google Sign-In error: $error');
  //     SmartDialog.showToast("Google登录失败: $error");
  //     rethrow;
  //   }
  // }

  // GoogleSignInAuthentication getAuthTokens(GoogleSignInAccount account) {
  //   // authentication is now synchronous
  //   return account.authentication;
  // }

  // Future<String?> getAccessTokenForScopes(List<String> scopes) async {
  //   await _ensureGoogleSignInInitialized();

  //   try {
  //     final authClient = _googleSignIn.authorizationClient;

  //     // Try to get existing authorization
  //     var authorization = await authClient.authorizationForScopes(scopes);

  //     authorization ??= await authClient.authorizeScopes(scopes);

  //     return authorization.accessToken;
  //   } catch (error) {
  //     print('Failed to get access token for scopes: $error');
  //     SmartDialog.showToast("获取访问令牌失败: $error");
  //     return null;
  //   }
  // }
}
