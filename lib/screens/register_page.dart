import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fire_auth_core/widgets/custom_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({super.key, required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();

  Future signUp() async {
    if (passwordConfirmed()) {
      //create user
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      //add user details
      addUserDetails(
        _firstNameController.text.trim(),
        _lastNameController.text.trim(),
        _emailController.text.trim(),
        int.parse(
          _ageController.text.trim(),
        ),
      );
    }
  }

  Future addUserDetails(
      String firstName, String lastName, String email, int age) async {
    await FirebaseFirestore.instance.collection('users').add({
      'First Name': firstName,
      'Last Name': lastName,
      'Email': email,
      'Age': age,
    });
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
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
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Sign up
                Text(
                  'Hello there!',
                  style: GoogleFonts.bebasNeue(fontSize: 54),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  'You\'re welcome, Register here!',
                  style: TextStyle(fontSize: 20.0),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                //first name texfield
                CustomTextField(
                  emailController: _firstNameController,
                  hintText: 'First Name',
                  isObscured: false,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                //Last name
                CustomTextField(
                  emailController: _lastNameController,
                  hintText: 'Last Name',
                  isObscured: false,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                //age textfield
                CustomTextField(
                  emailController: _ageController,
                  hintText: 'Age',
                  isObscured: false,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                // email textfield
                CustomTextField(
                  emailController: _emailController,
                  hintText: 'Email',
                  isObscured: false,
                ),
                const SizedBox(
                  height: 10.0,
                ),

                //password textfield
                CustomTextField(
                  emailController: _passwordController,
                  hintText: 'Password',
                  isObscured: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                //confirm password
                CustomTextField(
                  emailController: _confirmPasswordController,
                  hintText: 'Confirm Password',
                  isObscured: true,
                ),
                const SizedBox(
                  height: 30,
                ),
                //register button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: signUp,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'I\'m a member! ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
