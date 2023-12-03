import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:railway_food_ordering/screen/wedget/my_text_field.dart';

class LoginPage extends StatefulWidget {
  static Pattern pattern =
      r'^(([^<>()[\]\\,;:\s@\"]+9\.[^<>()[\]\\,;:\s@"]+)*)|(\".+\"))@((\[[0-9]{1.3}\.[0-9]{1.3}\.[0-9]{1.3}\.[0-9]{1.3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loadding = false;
  RegExp regExp = RegExp('LoginPage.pattern');
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  late UserCredential userCredential;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future loginAuth() async {
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // ignore: deprecated_member_use
        globalKey.currentState!.showSnackBar(
          SnackBar(
            content: Text("No User found for that Email."),
          ),
        );
      } else if (e.code == 'wrong-password') {
        // ignore: deprecated_member_use
        globalKey.currentState!.showSnackBar(
          SnackBar(
            content: Text("Worng password provided for that user."),
          ),
        );
        setState(() {
          loadding = false;
        });
      }
      setState(() {
        loadding = false;
      });
    }
  }

  void validation() {
    if (email.text.trim().isEmpty ||
        // ignore: unnecessary_null_comparison
        email.text.trim() == null && password.text.trim().isEmpty ||
        // ignore: unnecessary_null_comparison
        password.text.trim() == null) {
      globalKey.currentState!
          // ignore: deprecated_member_use
          .showSnackBar(
        SnackBar(
          content: Text("All Field is Empty"),
        ),
      );
    }
    // ignore: unnecessary_null_comparison
    if (email.text.trim().isEmpty || email.text.trim() == null) {
      globalKey.currentState!
          // ignore: deprecated_member_use
          .showSnackBar(
        SnackBar(
          content: Text("Email is Empty"),
        ),
      );
      return;
    }
    // ignore: unnecessary_null_comparison
    if (password.text.trim().isEmpty || password.text.trim() == null) {
      globalKey.currentState!
          // ignore: deprecated_member_use
          .showSnackBar(
        SnackBar(
          content: Text("Password is Empty"),
        ),
      );
      return;
    } else {
      setState(() {
        loadding = true;
      });
      loginAuth();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 130),
              child: Text(
                "Login In",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              children: [
                MyTextField(
                  controller: email,
                  hintText: "Email",
                  obscureText: false,
                ),
                SizedBox(
                  height: 30,
                ),
                MyTextField(
                  controller: password,
                  hintText: "Password",
                  obscureText: true,
                ),
              ],
            ),
            // ignore: deprecated_member_use
            loadding
                ? CircularProgressIndicator()
                : Container(
                    height: 60,
                    width: 200,
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      onPressed: () {
                        validation();
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "New User?",
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  "Register Now",
                  style: TextStyle(color: Colors.red),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
