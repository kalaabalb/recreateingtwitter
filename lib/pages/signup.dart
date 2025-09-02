import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trail12/models/user.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});
  @override
  State<Signup> createState() => _Signup();
}

class _Signup extends State<Signup> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _globalKey = GlobalKey();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final RegExp validEmail =
  RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+$');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
          key: _globalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FaIcon(
                FontAwesomeIcons.twitter,
                color: Colors.blue,
                size: 70,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Log in to Twitter',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20)),
                child: TextFormField(
                  controller: emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter email',
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'fill out the email';
                    } else if (!(validEmail.hasMatch(value))) {
                      return 'fill out a proper email address';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextFormField(
                  controller: passwordCtrl,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Enter password',
                      border: InputBorder.none,
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'fill out the password';
                    } else if (value.length < 6) {
                      return 'password must be more than 6 characters';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                width: 230,
                padding: EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 48, 162, 255),
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                    onPressed: () async {
                      if (_globalKey.currentState!.validate()) {
                        try {
                          await _auth.createUserWithEmailAndPassword(
                              email: emailCtrl.text, password: passwordCtrl.text);
                         await _firestore
                              .collection('users')
                              .add(FirebaseUser(email: emailCtrl.text).toMap());
                         if(!mounted)return ;
                         Navigator.pop(context);
                        } catch (e) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(e.toString())));
                          print(e.toString());
                        }
                      }
                    },
                    child: Text(
                      'submit',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Already have an account? Log in',
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
          ),
        ));
  }
}
