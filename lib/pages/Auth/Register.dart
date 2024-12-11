import 'package:flutter/material.dart';
import 'package:vigenesia/utils/ButtonGlobal.dart';
import 'package:vigenesia/utils/TextFromGlobal.dart';
import 'package:vigenesia/utils/global.color.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 150,
                    height: 150,
                  ),
                ),
                const SizedBox(height: 50),
                Text(
                  'Create your account',
                  style: TextStyle(
                    color: GlobalColors.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 15),
                // Username input
                TextFormGlobal(
                  controller: userController,
                  text: 'Username',
                  obscureText: false,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 10),
                // Password input
                TextFormGlobal(
                  controller: passController,
                  text: 'Password',
                  obscureText: true,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 10),
                // Confirm Password input
                TextFormGlobal(
                  controller: confirmPassController,
                  text: 'Confirm Password',
                  obscureText: true,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 10),
                ButtonGlobal(
                  text: 'Sign Up',
                  onPressed: () {
                    print('register');
                  },
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Already have an account?',
            ),
            const SizedBox(width: 5),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/login'); 
              },
              child: Text(
                'Sign In',
                style: TextStyle(
                  color: GlobalColors.mainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
