import 'package:dt_todo/blocs/user_blocs.dart';
import 'package:dt_todo/models/user_model.dart';
import 'package:dt_todo/ui/CategoryScreen/category_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';



class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final googleSignIn = new GoogleSignIn();
  final analytics = new FirebaseAnalytics();
  final reference = FirebaseDatabase.instance.reference().child('messages');
  final user = UserModel();
  final userBloc = UserBloc();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        color: Color.fromRGBO(77, 213, 153, 1),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomRight,
              widthFactor: 0.6,
              heightFactor: 0.6,
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(200)),
                color: Color.fromRGBO(255, 255, 255, 0.4),
                child: Container(
                  width: 400,
                  height: 400,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              widthFactor: 0.5,
              heightFactor: 0.6,
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(200)),
                color: Color.fromRGBO(255, 255, 255, 0.4),
                child: Container(
                  width: 400,
                  height: 400,
                ),
              ),
            ),
            Center(
              child: Container(
                width: 400,
                height: 800,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Material(
                        elevation: 20.0,
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'images/coins.png', width: 80, height: 80,),
                        )),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: SizedBox(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 2 / 3,
                              child: GoogleSignInButton(
                                onPressed: signInWithGoogle,
                              )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: SizedBox(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 2 / 3,
                              child: FlatButton(
                                child: Text('Sign out'),
                                onPressed: signOutGoogle,
                              )
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToHomePage() {
    /*Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => CategoryScreen(), fullscreenDialog: true));*/
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
    this.user.avatar = user.photoUrl;

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
