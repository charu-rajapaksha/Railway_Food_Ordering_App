import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:railway_food_ordering/screen/wedget/my_text_field.dart';

class SignUp extends StatefulWidget {
  static Pattern pattern =
      r'^(([^<>()[\]\\,;:\s@\"]+9\.[^<>()[\]\\,;:\s@"]+)*)|(\".+\"))@((\[[0-9]{1.3}\.[0-9]{1.3}\.[0-9]{1.3}\.[0-9]{1.3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  @override
  _SignUpState createState() => _SignUpState();
}

@override
class _SignUpState extends State<SignUp> {
  bool loading = false;
  late UserCredential userCredential;
  RegExp regExp = RegExp('SignUp.pattern');
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  Future sendData() async {
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text);

      await FirebaseFirestore.instance
          .collection('userData')
          .doc(userCredential.user!.uid)
          .set({
        "firstName": firstName.text.trim(),
        "lastName": lastName.text.trim(),
        "email": email.text.trim(),
        "Userid": userCredential.user!.uid,
        "password": password.text.trim(),
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // ignore: deprecated_member_use
        globalKey.currentState!.showSnackBar(
          SnackBar(
            content: Text("The password provide is too weak"),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        // ignore: deprecated_member_use
        globalKey.currentState!.showSnackBar(
          SnackBar(
            content: Text("The account already exist for that email"),
          ),
        );
      }
    } catch (e) {
      // ignore: deprecated_member_use
      globalKey.currentState!.showSnackBar(
        SnackBar(
          content: Text("e"),
        ),
      );
      setState(() {
        loading = false;
      });
    }
    setState(() {
      loading = false;
    });
  }

  void validation() {
    // ignore: unnecessary_null_comparison
    if (firstName.text.trim().isEmpty || firstName.text.trim() == null) {
      // ignore: deprecated_member_use
      globalKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(
            "FirstName is Empty",
          ),
        ),
      );
      return;
    } else if (!regExp.hasMatch(email.text)) {
      // ignore: deprecated_member_use
      globalKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(
            "Please Enter valid Email",
          ),
        ),
      );
      return;
    }

    // ignore: unnecessary_null_comparison
    if (lastName.text.trim().isEmpty || lastName.text.trim() == null) {
      // ignore: deprecated_member_use
      globalKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(
            "LastName is Empty",
          ),
        ),
      );
      return;
    }
    // ignore: unnecessary_null_comparison
    if (email.text.trim().isEmpty || email.text.trim() == null) {
      // ignore: deprecated_member_use
      globalKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(
            "Email is Empty",
          ),
        ),
      );
      return;
    } else if (!regExp.hasMatch(email.text)) {
      // ignore: deprecated_member_use
      globalKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(
            "Plase enter vaild Email",
          ),
        ),
      );
      return;
    }

    // ignore: unnecessary_null_comparison
    if (password.text.trim().isEmpty || password.text.trim() == null) {
      // ignore: deprecated_member_use
      globalKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(
            "Password is Empty",
          ),
        ),
      );
      return;
    } else {
      sendData();
    }
  }

  Widget button(
      {required String buttonName,
      required Color color,
      required Color textColor,
      required Function ontap}) {
    return Container(
      width: 120,
      // ignore: deprecated_member_use
      child: RaisedButton(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          buttonName,
          style: TextStyle(fontSize: 20, color: textColor),
        ),
        onPressed: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Sign Up",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
              ),
              Container(
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyTextField(
                      controller: firstName,
                      obscureText: false,
                      hintText: "FirstName",
                    ),
                    MyTextField(
                      controller: lastName,
                      obscureText: false,
                      hintText: "LastName",
                    ),
                    MyTextField(
                      controller: email,
                      obscureText: false,
                      hintText: "Email",
                    ),
                    MyTextField(
                      controller: password,
                      obscureText: true,
                      hintText: "Password",
                    ),
                  ],
                ),
              ),
              loading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        button(
                            ontap: () {},
                            buttonName: "Cancel",
                            color: Colors.grey,
                            textColor: Colors.black),
                        SizedBox(
                          width: 10,
                        ),
                        button(
                          ontap: () {
                            validation();
                          },
                          buttonName: "Register",
                          color: Colors.red,
                          textColor: Colors.white,
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
