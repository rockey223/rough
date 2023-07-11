import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
// controller for getting value from text field
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  void resetControllers() {
    username.clear();
    password.clear();
  }

  String _error = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 20, 20, 20),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                'Login',
                style: TextStyle(fontSize: 36, color: Colors.white),
              ),
            ),
            // username input field
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 10, 20, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.white))),
                style: const TextStyle(color: Colors.white),
                controller: username,
              ),
            ),
            // password input field
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 10, 20, 0),
              child: TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.white))),
                style: const TextStyle(color: Colors.white),
                controller: password,
              ),
            ),
            Text(
              _error,
              style: TextStyle(color: Color.fromRGBO(189, 6, 6, 1)),
            ),
            ElevatedButton(
                onPressed: () async {
                  var Email = username.text;
                  var Password = password.text;

                  var response = await http.post(
                    Uri.parse('http://localhost:8000/login'),
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: jsonEncode(<String, String>{
                      'email': Email,
                      'password': Password,
                    }),
                  );
                  if (response.statusCode == 200) {
                    // Data posted successfully
                    // Handle the response here if needed
                    print(response.body);
                    resetControllers();
                    Fluttertoast.showToast(
                      msg: response.body,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                    );
                  } else {
                    // Error occurred during data posting
                    // Handle the error here if needed
                    print(response.statusCode);
                  }
                  // if (Email == "hello" && Password == "1234") {
                  //   _error = "";
                  //   username.clear();
                  //   password.clear();
                  // } else {
                  //   setState(() {
                  //     _error = "Email and password didn't match";
                  //   });
                  // }
                },
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 20),
                )),
          ],
        ),
      ),
    );
  }
}
