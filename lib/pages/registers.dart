// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistersPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegistersPage({super.key, required this.showLoginPage});

  @override
  State<RegistersPage> createState() => _RegistersPageState();
}

class _RegistersPageState extends State<RegistersPage> {
  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();

  Future signUp() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim())
          //I've added a .then() method to give us a 'user' object
          .then(
            (user) => addUserDetails(
              //I have passed the 'user' object to the adding method
              user: user,
              firstName: _firstNameController.text.trim(),
              lastName: _lastNameController.text.trim(),
              email: _emailController.text.trim(),
              age: int.parse(
                _ageController.text.trim(),
              ),
            ),
          );
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  Future addUserDetails(
      //I've made the parameters named and required
      //I've also added the 'user' parameter which we get from creating the user
      {required UserCredential user,
      required String firstName,
      required String lastName,
      required String email,
      required int age}) async {
    await FirebaseFirestore.instance
        .collection('users')
        //I have added .doc() method which used uid from 'user' object to set the documents name

        .doc(user.user?.uid)
        //I've changed .add() to .set() so that you can change user's details easily
        .set({
      'first name': firstName,
      'last name': lastName,
      'email': email,
      'age': age,
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // Hello again
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Icon(
                    Icons.android,
                    size: 100,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Hello there!",
                    style: GoogleFonts.bebasNeue(fontSize: 52),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Register below with your details",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)),
                    child: TextField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueAccent),
                              borderRadius: BorderRadius.circular(12)),
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintText: "First Name"),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)),
                    child: TextField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueAccent),
                              borderRadius: BorderRadius.circular(12)),
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintText: "Last Name"),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)),
                    child: TextField(
                      controller: _ageController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueAccent),
                              borderRadius: BorderRadius.circular(12)),
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintText: "Age"),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Email textfield
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueAccent),
                              borderRadius: BorderRadius.circular(12)),
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintText: "Email"),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Password textfield
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueAccent),
                              borderRadius: BorderRadius.circular(12)),
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintText: "Password"),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // confirm Password textfield
                  // Container(
                  //   decoration: BoxDecoration(
                  //       color: Colors.grey[200],
                  //       border: Border.all(color: Colors.white),
                  //       borderRadius: BorderRadius.circular(12)),
                  //   child: TextField(
                  //     controller: _confirmPasswordController,
                  //     obscureText: true,
                  //     decoration: InputDecoration(
                  //         enabledBorder: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(12),
                  //             borderSide: BorderSide(color: Colors.white)),
                  //         focusedBorder: OutlineInputBorder(
                  //             borderSide: BorderSide(color: Colors.blueAccent),
                  //             borderRadius: BorderRadius.circular(12)),
                  //         filled: true,
                  //         fillColor: Colors.grey[200],
                  //         hintText: "Confirm Password"),
                  //   ),
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  // first name textfield

                  SizedBox(
                    height: 10,
                  ),
                  // Sign in button
                  GestureDetector(
                    onTap: signUp,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                          child: Text(
                        "Sign up",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      )),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // not a member
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        "Already a member?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: widget.showLoginPage,
                        child: Text.rich(TextSpan(
                            text: " Login Now",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold))),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
