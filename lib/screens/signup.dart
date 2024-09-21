import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  String? username, email, password;

  // This function performs sign-up and saves user data to Firestore
  void signUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Saves the form data

      try {
        // Create the user with email and password
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email!,
          password: password!,
        );

        User? user = userCredential.user; // Get the current user

        // Save additional user data in Firestore
        if (user != null) {
          await _firestore.collection('users').doc(user.uid).set({
            'username': username,
            'email': email,
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('SignUp Successful!'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              // To make it float above the UI
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
          // Optionally, navigate to home page after success
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.of(context).pushReplacementNamed('/login_page');
          });
        }
      } catch (e) {
        // Handle error
        print("Error during signup: $e");
        // Optionally show a snackbar for error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('SignUp Failed! Please try again.'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignUp', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(
          color: Colors.white, // Change back arrow color to white
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Image.asset(
                    'assets/images/login_signup.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),
              // Username input
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.blue),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Enter a username' : null,
                onSaved: (value) => username = value,
              ),
              SizedBox(
                height: 16,
              ),
              // Email input
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.blue),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                validator: (value) => value!.isEmpty ? 'Enter an email' : null,
                onSaved: (value) => email = value,
              ),
              SizedBox(
                height: 16,
              ),
              // Password input
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.blue),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                obscureText: true,
                validator: (value) =>
                    value!.length < 6 ? 'Password too short' : null,
                onSaved: (value) => password = value,
              ),
              const SizedBox(height: 20),
              // Sign up button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  textStyle: TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  foregroundColor: Colors.white,
                  elevation: 2,
                ),
                onPressed: signUp, // Call signUp function on button press
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
