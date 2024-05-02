import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:godzilla/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:godzilla/common/toast.dart';
import 'package:godzilla/loginandsign/sign_up_page.dart';
import 'package:godzilla/widget/form_container_widget.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:local_auth/local_auth.dart';
import 'package:godzilla/view/main_tab/main_tab_view.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Monarca", style: TextStyle(fontWeight: FontWeight.bold)),
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
  bool _isSigning = false;
  final TextEditingController _usernameController = TextEditingController(text : 'user');
  final TextEditingController _passwordController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  void _authenticateWithBiometrics(BuildContext context) async {
  bool isBiometricAvailable = await _localAuthentication.canCheckBiometrics;

  if (isBiometricAvailable) {
    bool isAuthenticated = await _localAuthentication.authenticate(
      localizedReason: 'Autenticación necesaria para acceder',
    );

    if (isAuthenticated) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const MainTabView(
              
          ),
        ),
      );
    } else {
      const SnackBar(
        content: Text('La autenticación falló o fue cancelada por el usuario'),
      );
    }
  } else {
    const SnackBar(
        content: Text('No soportada la autenticación biometrica'),
      );
  }
}

  
  void _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        showToast(message: "Se ha iniciado sesion");
        Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const MainTabView(),
        ),
      );
      } else {
        showAboutDialog(
          context: context,
              applicationName: 'Organizator',
              applicationIcon: const FlutterLogo(),
              applicationLegalese: '© 2024',
              applicationVersion: '1.0.0',
              children: const [
              Text('No se pudo iniciar sesion con google'),
          ],
        );
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
                  FormContainerWidget(
                    keyboardType: TextInputType.emailAddress,
                controller: _usernameController,
                hintText: "user: user@ejemplo.com",
                isPasswordField: false,
              ),
                  const SizedBox(height: 16.0),
                  FormContainerWidget(  
                    keyboardType: TextInputType.text,
                controller: _passwordController,
                hintText: "Contraseña: 123456",
                isPasswordField: true,  
              ),
                  //TextField(
                    //controller: _usernameController,
                   // decoration: const InputDecoration(
                      //labelText: 'user: user@ejemplo.com',
                      //prefixIcon: Icon(Icons.person),
                    //),
                  //),
                  //const SizedBox(height: 16.0),
                  //TextField(
                    //controller: _passwordController,
                    //obscureText: true,
                    //decoration: const InputDecoration(
                     // labelText: 'Contraseña: 123456',
                      //prefixIcon: Icon(Icons.lock),
                    //),
                  //),
                  const SizedBox (height: 30.0),
                  GestureDetector(
                    onTap: () {
                      _signIn();
                    },
                    child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 121, 102, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: _isSigning ? const CircularProgressIndicator(
                    color: Colors.white) : const Text(
                      "Iniciar sesión",
                      style:  TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                  ),
                  const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("No tienes cuenta?"),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Registrate",
                      style: TextStyle(
                        color: Color.fromRGBO(63, 62, 76, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(63, 62, 76, 1),
                    ),
                    onPressed: _signInWithGoogle,
                    icon: const Icon(Icons.account_circle, color: Color.fromARGB(255, 223, 223, 236),),
                    label: const Text('Sign In with Google', style: TextStyle(color: Color.fromARGB(255, 223, 223, 236),),),
                  ),
                  const SizedBox(height: 5),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(63, 62, 76, 1),
                    ),
                    onPressed: () {
                      if(_usernameController.text == 'user'){
                        showToast(message: "Se ha iniciado sesion");
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
                    icon: const Icon(Icons.fingerprint, color: Color.fromARGB(255, 223, 223, 236),),
                    label: const Text('Autenticar con huella digital', style: TextStyle(color: Color.fromARGB(255, 223, 223, 236),),),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  void _signIn() async {
    setState(() {
      _isSigning = true;
    });

    String email = _usernameController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSigning = false;
    });

    if (user != null) {
      showToast(message: "Se ha iniciado sesión");
      Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainTabView()),
      (route) => false,
                      );
    } else {
      showToast(message: "Ocurrió un error");
    }
  }
  
}