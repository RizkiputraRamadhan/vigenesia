import 'package:flutter/material.dart';
import 'package:vigenesia/API/Auth.dart';
import 'package:vigenesia/Helpers/Sessions.dart';
import 'package:vigenesia/utils/ButtonGlobal.dart';
import 'package:vigenesia/utils/TextFromGlobal.dart';
import 'package:vigenesia/utils/global.color.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool isLoading = false;

  void handleLogin() async {
    final username = userController.text.trim();
    final password = passController.text.trim();

    setState(() {
      isLoading = true;
    });

    final response = await AuthService.Login(username, password);

    setState(() {
      isLoading = false;
    });

    if (response['status'] == 200) {
      showSnackbar('Login berhasil!', Colors.green);
      Navigator.pushNamed(context, '/home');
    } else {
      showSnackbar(response['message'] ?? 'Terjadi kesalahan.', Colors.red);
    }
  }

  void showSnackbar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String? token = Sessions.getToken();

    if (token != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, '/home');
      });
    }

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
                  'Login to your account',
                  style: TextStyle(
                    color: GlobalColors.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 15),
                // email input
                TextFormGlobal(
                  controller: userController,
                  text: 'Username',
                  obscureText: false,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 10),
                // password input
                TextFormGlobal(
                  controller: passController,
                  text: 'Password',
                  obscureText: true,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 10),
                ButtonGlobal(
                  text: isLoading ? 'Loading...' : 'Sign In',
                  onPressed: isLoading
                      ? () {}
                      : () => handleLogin(), 
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
            const Text("Don't have an account?"),
            const SizedBox(width: 5),
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
