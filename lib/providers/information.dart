import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:plantilla_login_register/models/tree.dart';

class Information extends ChangeNotifier {
  final String _baseUrl =
      'https://examen-practic-sim-default-rtdb.europe-west1.firebasedatabase.app';

  List<Tree> treeList = [];

  Information() {
    // Constructor to initialize the Information class
    print('Information initialized!');
    getTrees(); // Fetch tree data upon initialization
  }

  Future<void> getTrees() async {
    // Method to fetch tree data from the API
    var url = Uri.parse('$_baseUrl/arbres.json');
    final result = await http.get(url);

    if (result.statusCode == 200) {
      // If the HTTP request is successful (status code 200)
      var jsonResponse = convert.jsonDecode(result.body);
      if (jsonResponse is Map<String, dynamic>) {
        jsonResponse.forEach((key, treeData) {
          // Convert JSON data to Tree objects and add them to the list
          Tree tree = Tree.fromMap(treeData);
          treeList.add(tree);
        });

        notifyListeners(); // Notify listeners about the change in data
      }
    } else {
      // Handle error if the HTTP request fails
      print('Failed to load trees. Status code: ${result.statusCode}');
    }

    print(treeList); // Print the list of trees for debugging
  }

  Future<void> deleteTree(Tree tree) async {
    // Method to delete a tree from the API
    var url = Uri.parse('$_baseUrl/arbres.json');
    final result = await http.get(url);

    if (result.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(result.body);
      if (jsonResponse is Map<String, dynamic>) {
        var keys = jsonResponse.keys.toList();
        for (var key in keys) {
          var treeData = jsonResponse[key];
          // Adjust the comparison based on available unique property for trees
          if (treeData['nom'] == tree.nom) {
            var deleteUrl = Uri.parse('$_baseUrl/arbres/$key.json');
            final deleteResult = await http.delete(deleteUrl);

            if (deleteResult.statusCode == 200) {
              // If deletion is successful, remove the tree from the list
              treeList.remove(tree);
              notifyListeners();
            } else {
              // Handle error if tree deletion fails
              print(
                  'Failed to delete tree. Status code: ${deleteResult.statusCode}');
            }

            break; // Stop searching once the tree is found and deleted
          }
        }
      }
    } else {
      // Handle error if the HTTP request fails
      print('Failed to load trees. Status code: ${result.statusCode}');
    }
  }

  Future<void> createTree(String nom, String varietat, String tipus,
      bool autocton, String foto, String detall) async {
    // Method to create a new tree and add it to the API
    var url = Uri.parse('$_baseUrl/arbres.json');
    final result = await http.post(
      url,
      body: convert.jsonEncode({
        'nom': nom,
        'varietat': varietat,
        'tipus': tipus,
        'autocton': autocton,
        'foto': foto,
        'detall': detall,
      }),
    );

    if (result.statusCode == 200) {
      // If creation is successful, retrieve the newly created tree from the response
      var jsonResponse = convert.jsonDecode(result.body);
      Tree newTree = Tree.fromMap(jsonResponse);

      // Add the new tree to the list
      treeList.add(newTree);
      notifyListeners();
    } else {
      // Handle error if tree creation fails
      print('Failed to create tree. Status code: ${result.statusCode}');
    }
  }

  void clearTreeList() {
    // Method to clear the list of trees
    treeList.clear();
    notifyListeners();
  }
}
