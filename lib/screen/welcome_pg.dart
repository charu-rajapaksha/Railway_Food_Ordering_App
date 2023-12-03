import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  Widget button(
      {required String name, required Color color, required Color textColor}) {
    return Container(
      height: 45,
      width: 300,
      // ignore: deprecated_member_use
      child: RaisedButton(
        color: Colors.blueAccent,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.blue, width: 20),
            borderRadius: BorderRadius.circular(10)),
        onPressed: () {},
        child: Text(
          name,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: Container(
            child: Center(
              child: Image.asset("images/logo1.png"),
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Welcome to Food Track",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey),
                ),
                Column(
                  children: [
                    Text("Order food our Restuarent and "),
                    Text("Make reservation in real-time")
                  ],
                ),
                button(
                    name: 'Login', color: Colors.blue, textColor: Colors.white),
                button(
                    name: 'SignUp',
                    color: Colors.blue,
                    textColor: Colors.white),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
