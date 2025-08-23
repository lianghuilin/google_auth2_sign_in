import 'package:flutter/material.dart';
import 'package:google_sign_in_demo/google_auth_service.dart';
// import 'package:toastification/toastification.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage(title: 'Google SignIn v.${DateTime.now().minute}'),
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GoogleAuthService googleAuthService = GoogleAuthService();
  GoogleSignInAccount? _currentUser;
  String? accessToken;
  String? idToken;
  String? serverAuthCode;

  Future<void> _handleSignIn() async {
    try {
      // 登录操作
      final GoogleSignInAccount? account = await googleAuthService
          .signInWithGoogle();
      if (account != null) {
        setState(() {
          _currentUser = account;
        });

        // 获取idToken
        final GoogleSignInAuthentication authentication = googleAuthService
            .getAuthTokens(account);
        setState(() {
          idToken = authentication.idToken;
        });

        // 获取accessToken
        final String? authAccessToken = await googleAuthService
            .getAccessTokenForScopes(GoogleAuthService.scopes);
        setState(() {
          accessToken = authAccessToken;
        });

        // 获取serverAuthCode
        final GoogleSignInServerAuthorization? serverAuth = await _currentUser!
            .authorizationClient
            .authorizeServer(GoogleAuthService.scopes);
        setState(() {
          serverAuthCode = serverAuth?.serverAuthCode;
        });
      } else {
        SmartDialog.showToast("登录失败");
      }
    } catch (e) {
      SmartDialog.showToast("${e.toString()}");
      // toastification.show(
      //   context: context, // optional if you use ToastificationWrapper
      //   title: Text('${e.toString()}'),
      //   type: ToastificationType.error,
      // );
    }

    // try {
    //   _googleSignIn.authenticationEvents.listen((event) async {
    //     switch (event) {
    //       case GoogleSignInAuthenticationEventSignIn():
    //         setState(() {
    //           _currentUser = event.user;
    //           idToken = _currentUser?.authentication.idToken;
    //         });

    //         toastification.show(
    //           context: context, // optional if you use ToastificationWrapper
    //           title: Text("idToken: $idToken"),
    //           type: ToastificationType.success,
    //         );
    //         break;
    //       default:
    //     }
    //     _googleSignIn.attemptLightweightAuthentication();

    //     if (_currentUser != null) {
    //       final GoogleSignInClientAuthorization? authorization =
    //           await _currentUser!.authorizationClient.authorizationForScopes([
    //             'openid',
    //             'email',
    //           ]);

    //       setState(() {
    //         accessToken = authorization?.accessToken;
    //       });

    //       final GoogleSignInServerAuthorization? serverAuth =
    //           await _currentUser!.authorizationClient.authorizeServer([
    //             'openid',
    //             'email',
    //           ]);

    //       if (serverAuth != null) {
    //         setState(() {
    //           serverAuthCode = serverAuth.serverAuthCode;
    //         });
    //         toastification.show(
    //           context: context, // optional if you use ToastificationWrapper
    //           title: Text("serverCode: $serverAuthCode"),
    //           type: ToastificationType.success,
    //         );
    //       }

    //       toastification.show(
    //         context: context, // optional if you use ToastificationWrapper
    //         title: Text('授权成功!'),
    //         type: ToastificationType.success,
    //       );
    //     }
    //   });
    // } catch (error) {
    //   toastification.show(
    //     context: context, // optional if you use ToastificationWrapper
    //     title: Text('${error.toString()}'),
    //     type: ToastificationType.info,
    //   );
    //   print(error);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_currentUser != null)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Google Nickname: ${_currentUser!.displayName}',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Google Email: ${_currentUser!.email}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Google accessToken: $accessToken'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Google idToken: $idToken'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Google serverAuthCode: $serverAuthCode'),
                  ),
                ],
              ),
            ElevatedButton(
              onPressed: _handleSignIn,
              child: const Text('Sign in with Google'),
            ),
          ],
        ),
      ),
    );
  }
}
