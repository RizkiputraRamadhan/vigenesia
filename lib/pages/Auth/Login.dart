import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vigenesia/utils/ButtonGlobal.dart';
import 'package:vigenesia/utils/TextFromGlobal.dart';
import 'package:vigenesia/utils/global.color.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController user = TextEditingController();
  final TextEditingController passController = TextEditingController();

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
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 150,
                  height: 150,
                ),
              ),

              const SizedBox(
                height: 50,
              ),
              Text(
                'Login to your account',
                style: TextStyle(
                  color: GlobalColors.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              //email input
              TextFormGlobal(
                controller: user,
                text: 'Username',
                obscureText: false,
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 10,
              ),
              //pass input
              TextFormGlobal(
                controller: passController,
                text: 'Password',
                obscureText: true,
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 10,
              ),
              ButtonGlobal(
                text: 'Sign In',
                onPressed: () {
                  print('login');
                   Navigator.pushNamed(context, '/home'); 
                },
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        )),
      ),
      bottomNavigationBar: Container(
        height: 50,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Don\'t have an account?',
            ),
            const SizedBox(
              width: 5,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text(
                'Sign Up',
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
