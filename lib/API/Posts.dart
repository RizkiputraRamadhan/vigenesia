import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vigenesia/API/Endpoint.dart';
import 'package:vigenesia/Helpers/Sessions.dart';

class PostsService {
  // Fetch user profile
  static Future<Map<String, dynamic>> getMyPost() async {
    final String? token = Sessions.getToken();
    if (token == null) {
      throw Exception("Token is null. User is not authenticated.");
    }

    try {
      final response = await http.get(
        Uri.parse('$API/posts?type=my'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          return data['user'];
        } else {
          throw Exception("Unexpected response structure: ${data['message']}");
        }
      } else {
        throw Exception(
            "Failed to fetch user profile. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching user profile: $e");
    }
  }

  static Future<Map<String, dynamic>> getFollowedPost() async {
    final String? token = Sessions.getToken();
    if (token == null) {
      throw Exception("Token is null. User is not authenticated.");
    }

    try {
      final response = await http.get(
        Uri.parse('$API/posts?type=followed'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          return data['user'];
        } else {
          throw Exception("Unexpected response structure: ${data['message']}");
        }
      } else {
        throw Exception(
            "Failed to fetch user profile. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching user profile: $e");
    }
  }

  // store
  static Future<Map<String, dynamic>> storePost(String post) async {
    // Validasi input
    if (post.isEmpty) {
      return {
        'status': 400,
        'message': 'Semua kolom harus diisi.',
      };
    }

    try {
      final String? token = Sessions.getToken();
      final response = await http.post(
        Uri.parse('$API/post'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'status': post,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return {
          'status': 200,
          'data': responseData['post'],
          'message': 'Postingan berhasil diupload.',
        };
      } else {
        return {
          'status': response.statusCode,
          'message': 'Postingan gagal diupload. Silakan coba lagi.',
        };
      }
    } catch (e) {
      return {
        'status': 500,
        'message': 'Terjadi kesalahan koneksi. Coba lagi nanti.',
      };
    }
  }

  static Future<Map<String, dynamic>> updatePost(id, String post) async {
    // Validasi input
    if (post.isEmpty) {
      return {
        'status': 400,
        'message': 'Semua kolom harus diisi.',
      };
    }

    try {
      final String? token = Sessions.getToken();
      final response = await http.patch(
        Uri.parse('$API/post/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'status': post,
        }),
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return {
          'status': 201,
          'data': responseData['post'],
          'message': 'Postingan berhasil diupload.',
        };
      } else {
        return {
          'status': response.statusCode,
          'message': 'Postingan gagal diupload. Silakan coba lagi.',
        };
      }
    } catch (e) {
      return {
        'status': 500,
        'message': 'Terjadi kesalahan koneksi. Coba lagi nanti.',
      };
    }
  }

  static Future<Map<String, dynamic>> deletePost(id) async {
    try {
      final String? token = Sessions.getToken();
      final response = await http.delete(
        Uri.parse('$API/post/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return {
          'status': 200,
          'data': responseData['post'],
          'message': 'Postingan berhasil dihapus.',
        };
      } else {
        return {
          'status': response.statusCode,
          'message': 'Postingan gagal dihapus. Silakan coba lagi.',
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
