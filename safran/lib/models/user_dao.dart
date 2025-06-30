import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user_dto.dart';

class UserDao {
  final String baseUrl;

  UserDao({this.baseUrl = 'https://api.monsite.com/users'});

  Future<UserDto?> getUserById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return UserDto.fromJson(json.decode(response.body));
    }
    return null;
  }
  
  Future<bool> insertUser(UserDto user) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()),
    );
    return response.statusCode == 201;
  }

  Future<bool> updateUser(UserDto user) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${user.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()),
    );
    return response.statusCode == 200;
  }

  Future<bool> deleteUser(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    return response.statusCode == 204;
  }
}
