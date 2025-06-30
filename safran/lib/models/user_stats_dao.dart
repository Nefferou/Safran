import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user_stats_dto.dart';

class UserStatsDao {
  final String baseUrl;

  UserStatsDao({this.baseUrl = 'https://api.monsite.com/userstats'});

  Future<UserStatsDto?> getUserStatsById(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/$userId'));
    if (response.statusCode == 200) {
      return UserStatsDto.fromJson(json.decode(response.body));
    }
    return null;
  }

  Future<bool> insertUserStats(UserStatsDto stats) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(stats.toJson()),
    );
    return response.statusCode == 201;
  }

  Future<bool> updateUserStats(UserStatsDto stats) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${stats.userId}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(stats.toJson()),
    );
    return response.statusCode == 200;
  }

  Future<bool> deleteUserStats(String userId) async {
    final response = await http.delete(Uri.parse('$baseUrl/$userId'));
    return response.statusCode == 204;
  }
} 