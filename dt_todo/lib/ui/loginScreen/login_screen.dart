import 'package:dt_todo/blocs/category_blocs.dart';
import 'package:dt_todo/blocs/user_blocs.dart';
import 'package:dt_todo/models/user_model.dart';
import 'package:dt_todo/ui/CategoryScreen/category_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';



/*
class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<WelcomeScreen> {
  final googleSignIn = new GoogleSignIn();
  final analytics = new FirebaseAnalytics();
  final reference = FirebaseDatabase.instance.reference().child('messages');
  final user = UserModel();
  final userBloc = UserBloc();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.blue,
        cursorColor: Colors.orange,
        textTheme: TextTheme(
          display2: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 45.0,
            color: Colors.white,
          ),
          button: TextStyle(
            fontFamily: 'OpenSans',
          ),
          subhead: TextStyle(fontFamily: 'NotoSans'),
          body1: TextStyle(fontFamily: 'NotoSans'),
        ),
      ),
      home: LoginScreen(),
    );
  }

  void navigateToHomePage() {
    */
/*Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => CategoryScreen(), fullscreenDialog: true));*//*

    Navigator.pushReplacementNamed(context, '/category_screen');
  }

  Future<bool> checkUserExist(UserModel data) async {
    final user = await userBloc.getUserByUsername(data.username);
    return user != null;
  }

  Future signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount
        .authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    this.user.uid = user.uid;
    this.user.username = user.email;

    bool userExist = await checkUserExist(this.user);
    if (!userExist) {
      userBloc.insertUser(this.user);
    }

    navigateToHomePage();
    return "đăng nhập thành công";
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();
    print("User Sign Out");
  }
}

*/


class LoginScreen extends StatelessWidget {
  final user = UserModel();
  final userBloc = UserBloc();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ignore: missing_return
  Future<String> _authUser(LoginData data) async {
    bool userExist = await checkUser(data);
    if(!userExist){
      return "Email not exists !";
    }
    try{
      // ignore: unnecessary_statements
      await _auth.signInWithEmailAndPassword(email: data.name, password: data.password);
      user.username = data.name.trim();

    } on Exception{
      return "Username or password incorrect";
    }
  }

  checkLogin(LoginData data) async{
    final user = await userBloc.getUserByUsername(data.name);
    return user!=null;
  }

  Future<bool> checkUser(LoginData data) async {
    final user = await userBloc.getUserByUsername(data.name);
    return user != null ;
  }



  // ignore: missing_return
  Future<String> authSignUp(LoginData data) async {
    user.username = data.name;

    bool userExist = await checkUser(data);
    if (userExist) {
      return "Tên người dùng đã tồn tại!";
    } else {
      userBloc.insertUser(user);
      try {
        FirebaseUser fbUser = (await _auth.createUserWithEmailAndPassword(
            email: data.name, password: data.password))
            .user;
        await fbUser.sendEmailVerification();
      } on PlatformException {
        return "Lỗi đăng nhập!";
      }
    }
  }

  Future<String> _recoverPassword(String name) async {
    user.username = name;
    await userBloc.getUserByUsername(name);
    await _auth.sendPasswordResetEmail(email: name);
    return Future.delayed(Duration(milliseconds: 500)).then((_) {
      if (name != user.username) {
        return 'Tên đăng nhập không tồn tại';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'To Do Note',
      logo: 'assets/images/ecorp.png',
      onLogin: _authUser,
      onSignup: authSignUp,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CategoryScreen(),
        ));
      },
      onRecoverPassword: _recoverPassword,
      messages: LoginMessages(
        usernameHint: 'Username',
        passwordHint: 'Pass',
        confirmPasswordHint: 'Confirm',
        loginButton: 'LOG IN',
        signupButton: 'REGISTER',
        forgotPasswordButton: 'Forgot password huh?',
        recoverPasswordButton: 'HELP ME',
        goBackButton: 'GO BACK',
        confirmPasswordError: 'Not match!',
        recoverPasswordDescription:
        'Please check your email to recover password',
        recoverPasswordSuccess: 'Password rescued successfully',
      ),
    );
  }
}