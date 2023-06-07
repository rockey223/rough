import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
// controller to get data from input field
  TextEditingController _fullName = TextEditingController();
  TextEditingController _userName = TextEditingController();
  TextEditingController _signupUsername = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _singupPassword = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();

  var _incorrectPassword = '';
  var _dupUsername = '';
  var _phonelength = '';

  void resetControllers() {
    _fullName.clear();
    _userName.clear();
    _email.clear();
    _singupPassword.clear();
    _confirmPassword.clear();
  }

  // var url = Uri.http('http://localhost:8000/signup');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromARGB(255, 20, 20, 20),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'SignUp'.toUpperCase(),
              style: TextStyle(fontSize: 36, color: Colors.white),
            ),
          ),
          // full Name
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 10, 20, 0),
            child: TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Full Name',
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.white))),
              style: const TextStyle(color: Colors.white),
              controller: _fullName,
            ),
          ),
          // username
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
              controller: _userName,
            ),
          ),
          Text(
            _dupUsername,
            style: TextStyle(color: Colors.red),
          ),
          // email
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 10, 20, 0),
            child: TextFormField(
              decoration: const InputDecoration(
                  labelText: 'email',
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.white))),
              style: const TextStyle(color: Colors.white),
              controller: _email,
            ),
          ),
          // Text(
          //   _phonelength,
          //   style: TextStyle(color: Colors.red),
          // ),
          // password
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 10, 20, 0),
            child: TextFormField(
              decoration: const InputDecoration(
                  labelText: 'password',
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.white))),
              style: const TextStyle(color: Colors.white),
              controller: _singupPassword,
            ),
          ),
          // confirm password
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 10, 20, 0),
            child: TextFormField(
              decoration: const InputDecoration(
                  labelText: 'confirm Password',
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.white))),
              style: const TextStyle(color: Colors.white),
              controller: _confirmPassword,
            ),
          ),
          Text(
            _incorrectPassword,
            style: TextStyle(color: Colors.red),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
            child: ElevatedButton(
                onPressed: () async {
                  var fullname = _fullName.text;
                  var username = _userName.text;
                  var email = _email.text;
                  var password = _singupPassword.text;
                  var confirmPassword = _confirmPassword.text;

                  if (password != confirmPassword) {
                    setState(() {
                      _incorrectPassword =
                          "password and confirm password must be same";
                    });
                  } else {
                    // send Db
                    // var response =
                    //     http.post(Uri.parse('http://localhost:8000/signup'),
                    //         headers: <String, String>{
                    //           'Content-Type': 'application/json; charset=UTF-8',
                    //         },
                    //         body: jsonEncode(<String, String>{
                    //           'name': fullname,
                    //           'username': username,
                    //           'email': email,
                    //           'password': password,
                    //           'confirmPassword': confirmPassword,
                    //         }));
                    var response = await http.post(
                      Uri.parse('http://localhost:8000/signup'),
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body: jsonEncode(<String, String>{
                        'name': fullname,
                        'username': username,
                        'email': email,
                        'password': password,
                        'confirmPassword': confirmPassword,
                      }),
                    );

                    // Check the response status
                    if (response.statusCode == 200) {
                      // Data posted successfully
                      // Handle the response here if needed
                      print(response.body);
                      resetControllers();
                      Fluttertoast.showToast(
                        msg: 'Signed up Successfull',
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
                  }
                },
                child: Text('SignUp', style: TextStyle(fontSize: 20))),
          ),
        ],
      ),
    ));
  }
}
