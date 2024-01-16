import 'dart:convert';
import 'package:http/http.dart' as http;
import './user.dart';

class UserService {
  String baseUrl = 'http://localhost:3000';  

  UserService(this.baseUrl);

Future<List<User>> getUsers() async {
  try {
    final response = await http.get(
      Uri.parse('$baseUrl/getAllUsers'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<User> users = data.map((json) => User.fromJson(json)).toList();
      return users;
    } else {
      throw Exception('Failed to load users - ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load users - $e');
  }
}



  Future<User> createUser(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/createUser'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create user');
    }
  }

//logic to implement updating user
   Future<void> updateUser(User user) async {
    final updateUrl = '$baseUrl/updateUser/${user.id}';  

    final response = await http.put(
      Uri.parse(updateUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'firstName': user.firstName,
        'lastName': user.lastName,
        'email': user.email,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update user - ${response.statusCode}');
    }
  }

  Future<void> deleteUser(String userId) async {
    final deleteUrl = '$baseUrl/deleteUserById/$userId'; 

    final response = await http.delete(Uri.parse(deleteUrl));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete user - ${response.statusCode}');
    }
  }
}
