import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vigenesia/API/Endpoint.dart';

class AuthService {
  // register
  static Future<Map<String, dynamic>> Register(
      String username, String password, String confirmPassword) async {
    // Validasi input
    if (username.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      return {
        'status': 400,
        'message': 'Semua kolom harus diisi.',
      };
    }

    if (password.length < 8) {
      return {
        'status': 400,
        'message': 'Password harus minimal 8 karakter.',
      };
    }

    if (password != confirmPassword) {
      return {
        'status': 400,
        'message': 'Password dan konfirmasi password tidak sesuai.',
      };
    }

    try {
      final response = await http.post(
        Uri.parse('$API/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'password': password,
          'password_confirmation': password,
        }),
      );

      if (response.statusCode == 200) {
        
        final responseData = json.decode(response.body);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token',  responseData['access_token']);
        await prefs.setString('username', responseData['data']['user']['username']);
        await prefs.setInt('user_id', responseData['data']['user']['id']);

        return {
          'status': 200,
          'message': 'Registrasi berhasil.',
        };
      } else {
        return {
          'status': response.statusCode,
          'message': 'Registrasi gagal. Silakan coba lagi.',
        };
      }
    } catch (e) {
      return {
        'status': 500,
        'message': 'Terjadi kesalahan koneksi. Coba lagi nanti.',
      };
    }
  }

// login
  static Future<Map<String, dynamic>> Login(
      String username, String password) async {
    // Validasi input
    if (username.isEmpty || password.isEmpty) {
      return {
        'status': 400,
        'message': 'Semua kolom harus diisi.',
      };
    }

    try {
      final response = await http.post(
        Uri.parse('$API/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token',  responseData['access_token']);
        await prefs.setString('username', responseData['data']['user']['username']);
        await prefs.setInt('user_id', responseData['data']['user']['id']);

        return {
          'status': 200,
          'message': 'Registrasi berhasil.',
        };
      } else {
        return {
          'status': response.statusCode,
          'message': 'Login gagal. Silakan coba lagi.',
        };
      }
    } catch (e) {
      return {
        'status': 500,
        'message': 'Terjadi kesalahan koneksi. Coba lagi nanti.',
      };
    }
  }
}
