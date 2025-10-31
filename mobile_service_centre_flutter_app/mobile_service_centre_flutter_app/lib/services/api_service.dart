import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class ApiService {
  // For physical device testing, use your machine's IP address
  // For Android emulator, use 'http://10.0.2.2:3000/api/v1'
  // For iOS simulator, use 'http://localhost:3000/api/v1'
  static const String baseUrl = 'http://192.168.20.20:3000/api/v1';
  static const String authUrl = '$baseUrl/auth';
  static const String customersUrl = '$baseUrl/customers';
  static const String jobsUrl = '$baseUrl/jobs';
  static const String staffUrl = '$baseUrl/staff';
  static const String stockUrl = '$baseUrl/stock';
  
  String? authToken;
  User? currentUser;
  
  // Admin login
  Future<Map<String, dynamic>?> adminLogin(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$authUrl/admin/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        authToken = data['token'];
        currentUser = User.fromJson(data['user']);
        return data;
      } else {
        throw Exception('Failed to login: ${response.body}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
  
  // Staff login
  Future<Map<String, dynamic>?> staffLogin(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$authUrl/staff/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        authToken = data['token'];
        currentUser = User.fromJson(data['user']);
        return data;
      } else {
        throw Exception('Failed to login: ${response.body}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
  
  // Get customers
  Future<List<dynamic>> getCustomers() async {
    if (authToken == null) {
      throw Exception('Not authenticated');
    }
    
    try {
      final response = await http.get(
        Uri.parse(customersUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load customers: ${response.body}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
  
  // Get jobs
  Future<List<dynamic>> getJobs() async {
    if (authToken == null) {
      throw Exception('Not authenticated');
    }
    
    try {
      final response = await http.get(
        Uri.parse(jobsUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load jobs: ${response.body}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
  
  // Get staff members
  Future<List<dynamic>> getStaff() async {
    if (authToken == null) {
      throw Exception('Not authenticated');
    }
    
    try {
      final response = await http.get(
        Uri.parse(staffUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load staff: ${response.body}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
  
  // Get stock items
  Future<List<dynamic>> getStock() async {
    if (authToken == null) {
      throw Exception('Not authenticated');
    }
    
    try {
      final response = await http.get(
        Uri.parse(stockUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load stock: ${response.body}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}