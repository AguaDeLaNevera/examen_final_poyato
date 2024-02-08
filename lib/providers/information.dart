import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:plantilla_login_register/models/user.dart';

class Information extends ChangeNotifier {
  final String _baseUrl =
      'https://examen-practic-sim-default-rtdb.europe-west1.firebasedatabase.app';

  List<User> userList = [];

  Information() {
    print('Information initialized!');
    getUsers();
  }

  Future<void> getUsers() async {
    var url = Uri.parse('$_baseUrl/users.json');
    final result = await http.get(url);

    if (result.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(result.body);
      if (jsonResponse is Map<String, dynamic>) {
        jsonResponse.forEach((key, userData) {
          User user = User.fromMap(userData);
          userList.add(user);
        });

        notifyListeners();
      }
    } else {
      // Handle error
      print('Failed to load users. Status code: ${result.statusCode}');
    }

    print(userList);
  }

  Future<void> deleteUser(User user) async {
    var url = Uri.parse('$_baseUrl/users.json');
    final result = await http.get(url);

    if (result.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(result.body);
      if (jsonResponse is Map<String, dynamic>) {
        var keys = jsonResponse.keys.toList();
        for (var key in keys) {
          var userData = jsonResponse[key];
          if (userData['email'] == user.email) {
            // Found the user based on email (adjust based on available unique property)
            var deleteUrl = Uri.parse('$_baseUrl/users/$key.json');
            final deleteResult = await http.delete(deleteUrl);

            if (deleteResult.statusCode == 200) {
              userList.remove(user);
              notifyListeners();
            } else {
              // Handle error
              print(
                  'Failed to delete user. Status code: ${deleteResult.statusCode}');
            }

            break; // Stop searching once the user is found and deleted
          }
        }
      }
    } else {
      // Handle error
      print('Failed to load users. Status code: ${result.statusCode}');
    }
  }

  Future<void> createUser(String name, String email, String address,
      String phone, String photo) async {
    var url = Uri.parse('$_baseUrl/users.json');
    final result = await http.post(
      url,
      body: convert.jsonEncode({
        'name': name,
        'email': email,
        'address': address,
        'phone': phone,
        'photo': photo,
      }),
    );

    if (result.statusCode == 200) {
      // Retrieve the newly created user from the response
      var jsonResponse = convert.jsonDecode(result.body);
      User newUser = User.fromMap(jsonResponse);

      // Add the new user to the list
      userList.add(newUser);
      notifyListeners();
    } else {
      // Handle error
      print('Failed to create user. Status code: ${result.statusCode}');
    }
  }

  void clearUserList() {
    userList.clear();
    notifyListeners();
  }
}
