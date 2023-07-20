import 'package:flutter/material.dart';
import 'package:movie_app/main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/googleAuth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  TextEditingController siginEmail = TextEditingController();
  TextEditingController siginPassword = TextEditingController();

  String? errorMessage;
  String getUserData = '';
  bool signUp = false;
  bool showPassword = true;

  FirebaseAuth auth = FirebaseAuth.instance;
  User? currentUser;

  userAuth() async {
    currentUser = await auth.currentUser;
    setState(() {});
  }

  // getToken(String userId, String password) async {
  //   print(">>>>>>");

  //   var data = await storeData(userId, password);
  //   print(data);
  //   setState(() {});
  // }

  // storeToken() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString('token');
  //   print("-------$token---------");
  //   setState(() {});
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
    userAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 23, 22, 22),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: signUp == false
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const Text(
                            "Welcome Back!",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Please sign in to your account",
                            style: TextStyle(
                                color: Colors.white54,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          TextFormField(
                            cursorColor: Colors.white54,
                            controller: siginEmail,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                                fillColor:
                                    const Color.fromARGB(31, 137, 146, 98),
                                filled: true,
                                hintText: "Email",
                                hintStyle: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20),
                                )),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            cursorColor: Colors.white54,
                            controller: siginPassword,
                            obscureText: showPassword,
                            autocorrect: false,
                            keyboardType: TextInputType.visiblePassword,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                                fillColor:
                                    const Color.fromARGB(31, 137, 146, 98),
                                filled: true,
                                hintText: "Password",
                                hintStyle: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      showPassword = !showPassword;
                                    });
                                  },
                                  icon: showPassword
                                      ? const Icon(
                                          FontAwesomeIcons.eyeSlash,
                                          color: Colors.white54,
                                          size: 20,
                                        )
                                      : const Icon(
                                          FontAwesomeIcons.eye,
                                          color: Colors.white54,
                                          size: 20,
                                        ),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none)),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 180),
                            child: TextButton(
                                onPressed: null,
                                child: Text(
                                  "Forget Password?",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                )),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(
                                      MediaQuery.of(context).size.width, 60),
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              onPressed: () async {
                                setState(() {
                                  
                                });
                                try {
                                  final credential = await auth
                                      .signInWithEmailAndPassword(
                                          email: siginEmail.text,
                                          password: siginPassword.text);

                                  if (credential == null) {
                                    print("NUll");
                                  } else {
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(
                                            builder: (context) {
                                      return const MoviesPage();
                                    }));
                                  }
                                } on FirebaseException catch (e) {
                                  if (e.code == 'user-not-found') {
                                    errorMessage =
                                        'No user found for that email.';
                                    print("Not found");
                                  } else if (e.code == 'wrong-password') {
                                    errorMessage =
                                        'Wrong password provided for that user.';
                                    print("Wrong password");
                                  } else {
                                    errorMessage = e.code;
                                    print(e);
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(e.toString())));
                                }

                                // String token = await getToken(idCtrl.text, passwordCtrl.text);
                                // final SharedPreferences prefs =
                                //     await SharedPreferences.getInstance();
                                //     await prefs.setString('token', token);
                                // idCtrl.clear();
                                // passwordCtrl.clear();
                                // setState(() {

                                // });
                              },
                              child: const Text(
                                "Sign In",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              )),
                          const SizedBox(
                            height: 15,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize:
                                    Size(MediaQuery.of(context).size.width, 60),
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            onPressed: () async{
                              var token = await AuthService().signInWithGoogle();
                            print("_____________:>>>>$token");
                            User? user = FirebaseAuth.instance.currentUser;
                            if (user != null) {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) {
                                return const MoviesPage();
                              }));
                              setState(() {});
                            }
                              setState(() {});
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage("images/google.png"),
                                  width: 30,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Sign in with Google",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      signUp = true;
                                    });
                                  },
                                  child: const Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 209, 30, 233),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ))
                            ],
                          )
                        ],
                      )
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const Text(
                            "Create new account",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Please fill in the form to continue",
                            style: TextStyle(
                                color: Colors.white54,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          TextFormField(
                            cursorColor: Colors.white54,
                            controller: nameCtrl,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                                fillColor:
                                    const Color.fromARGB(31, 137, 146, 98),
                                filled: true,
                                hintText: "Full name",
                                hintStyle: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20),
                                )),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            cursorColor: Colors.white54,
                            controller: emailCtrl,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                                fillColor:
                                    const Color.fromARGB(31, 137, 146, 98),
                                filled: true,
                                hintText: "Email",
                                hintStyle: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20),
                                )),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            cursorColor: Colors.white54,
                            controller: passwordCtrl,
                            obscureText: showPassword,
                            autocorrect: false,
                            keyboardType: TextInputType.visiblePassword,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                                fillColor:
                                    const Color.fromARGB(31, 137, 146, 98),
                                filled: true,
                                hintText: "Password",
                                hintStyle: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      showPassword = !showPassword;
                                    });
                                  },
                                  icon: showPassword
                                      ? const Icon(
                                          FontAwesomeIcons.eyeSlash,
                                          color: Colors.white54,
                                          size: 20,
                                        )
                                      : const Icon(
                                          FontAwesomeIcons.eye,
                                          color: Colors.white54,
                                          size: 20,
                                        ),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none)),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(
                                      MediaQuery.of(context).size.width, 60),
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              onPressed: () async {
                                try {
                                  final credential =
                                      await auth.createUserWithEmailAndPassword(
                                    email: emailCtrl.text,
                                    password: passwordCtrl.text,
                                  );
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'weak-password') {
                                    print('The password provided is too weak.');
                                  } else if (e.code == 'email-already-in-use') {
                                    print(
                                        'The account already exists for that email.');
                                  }
                                } catch (e) {
                                  print(e);
                                } finally {
                                  FirebaseAuth.instance.currentUser!
                                      .sendEmailVerification();
                                  debugPrint('email verification');
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) {
                                    return const MoviesPage();
                                  }));
                                }
                                nameCtrl.clear();
                                emailCtrl.clear();
                                passwordCtrl.clear();
                                setState(() {});
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              )),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an account?",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      signUp = false;
                                    });
                                  },
                                  child: const Text(
                                    "Sign In",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 209, 30, 233),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ))
                            ],
                          )
                        ],
                      )
                    ],
                  ),
          ),
        ));
  }
}
