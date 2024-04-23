import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:local_auth/local_auth.dart';
import 'package:godzilla/body/start.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Screen',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Iniciar Sesión'),
        ),
        body: const Center(
          child:  LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void _authenticateWithBiometrics(BuildContext context) async {
  bool isBiometricAvailable = await _localAuthentication.canCheckBiometrics;

  if (isBiometricAvailable) {
    bool isAuthenticated = await _localAuthentication.authenticate(
      localizedReason: 'Autenticación necesaria para acceder',
    );

    if (isAuthenticated) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const Start(),
        ),
      );
    } else {
      const SnackBar(
        content: Text('La autenticación falló o fue cancelada por el usuario'),
      );
    }
  } else {
    const SnackBar(
        content: Text('Comprate algo mejor perro'),
      );
  }
}

  
  void _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        print('User signed in with Google: ${googleUser.email}');
      } else {
        print('Failed to sign in with Google.');
      }
    } catch (error) {
      print('Error signing in with Google: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: navigatorKey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  const Text("Organizator", style: TextStyle(fontSize: 30, fontWeight:  FontWeight.bold), ),
                  const SizedBox(height: 100),
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Usuario',
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Contraseña',
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                  const SizedBox (height: 40.0),
                  ElevatedButton(
                    onPressed: () {
                      String username = _usernameController.text;
                      String password = _passwordController.text;
                      print('Username: $username, Password: $password');
                    },
                    child: const Text('Sign In'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: _signInWithGoogle,
                    icon: const Icon(Icons.account_circle),
                    label: const Text('Sign In with Google'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      if(_usernameController.text == 'user'){
                          _authenticateWithBiometrics(context);
                      } else {
                        showAboutDialog(
                          context: context,
                          applicationName: 'Organizator',
                          applicationIcon: const FlutterLogo(),
                          applicationLegalese: '© 2024',
                          applicationVersion: '1.0.0',
                          children: const [
                            Text('No se pudo autenticar con la huella digital'),
                          ],
                        );
                      }
                    
                    },
                    icon: const Icon(Icons.fingerprint),
                    label: const Text('Autenticar con huella digital'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  
}