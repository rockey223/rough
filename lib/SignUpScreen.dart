import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
// controller to get data from input field
  TextEditingController _fullName = TextEditingController();
  TextEditingController _signupUsername = TextEditingController();
  TextEditingController _phoneNo = TextEditingController();
  TextEditingController _singupPassword = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();

  var _incorrectPassword = '';
  var _dupUsername = '';
  var _phonelength = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'SignUp',
              style: TextStyle(fontSize: 36, color: Colors.white),
            ),
          ),
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
              controller: _fullName,
            ),
          ),
          Text(
            _dupUsername,
            style: TextStyle(color: Colors.red),
          ),
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
              controller: _phoneNo,
            ),
          ),
          Text(
            _phonelength,
            style: TextStyle(color: Colors.red),
          ),
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
              controller: _singupPassword,
            ),
          ),
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
                onPressed: () {
                  var fullname = _fullName.text;
                  var username = _signupUsername.text;
                  var phone = _phoneNo.text;
                  var password = _singupPassword.text;
                  var confirmPassword = _confirmPassword.text;
                },
                child: Text('SignUp', style: TextStyle(fontSize: 20))),
          ),
        ],
      ),
    ));
  }
}
