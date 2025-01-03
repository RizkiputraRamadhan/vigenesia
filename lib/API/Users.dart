import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vigenesia/API/Endpoint.dart';
import 'package:vigenesia/Helpers/Sessions.dart';

class UsersService {
  // Fetch user profile
  static Future<Map<String, dynamic>> getProfile() async {
    final String? token = Sessions.getToken();
    if (token == null) {
      throw Exception("Token is null. User is not authenticated.");
    }

    try {
      final response = await http.get(
        Uri.parse('$API/user'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          return data['data']; // Returning the 'data' object directly
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

  // get all
  static Future<Map<String, dynamic>> getAll() async {
    final String? token = Sessions.getToken();
    if (token == null) {
      throw Exception("Token is null. User is not authenticated.");
    }

    try {
      final response = await http.get(
        Uri.parse('$API/users'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          return data;
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

  static Future<Map<String, dynamic>> FollowByUsername(String username) async {
    final String? token = Sessions.getToken();
    if (token == null) {
      throw Exception("Token is null. User is not authenticated.");
    }

    try {
      final response = await http.post(
        Uri.parse('$API/follow/$username'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (data['success'] == true) {
          return data;
        } else {
          return data;
        }
      } else {
        return data;
      }
    } catch (e) {
      throw Exception("Error fetching user profile: $e");
    }
  }

  static Future<Map<String, dynamic>> UnFollowByUsername(
      String username) async {
    final String? token = Sessions.getToken();
    if (token == null) {
      throw Exception("Token is null. User is not authenticated.");
    }

    try {
      final response = await http.post(
        Uri.parse('$API/unfollow/$username'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (data['success'] == true) {
          return data;
        } else {
          return data;
        }
      } else {
        return data;
      }
    } catch (e) {
      throw Exception("Error fetching user profile: $e");
    }
  }

  static Future<Map<String, dynamic>> UserFollowers() async {
    final String? token = Sessions.getToken();
    final String? username = Sessions.getUsername();
    if (token == null || username == null) {
      throw Exception("Token or username is null. User is not authenticated.");
    }

    try {
      final response = await http.get(
        Uri.parse('$API/followings/$username'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (data['success'] == true) {
          return data;
        } else {
          return data;
        }
      } else {
        return data;
      }
    } catch (e) {
      throw Exception("Error fetching user profile: $e");
    }
  }
}
