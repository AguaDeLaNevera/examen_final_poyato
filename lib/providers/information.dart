import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:plantilla_login_register/models/tree.dart';

class Information extends ChangeNotifier {
  final String _baseUrl =
      'https://examen-practic-sim-default-rtdb.europe-west1.firebasedatabase.app';

  List<Tree> treeList = [];

  Information() {
    print('Information initialized!');
    getTrees();
  }

  Future<void> getTrees() async {
    var url = Uri.parse('$_baseUrl/arbres.json');
    final result = await http.get(url);

    if (result.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(result.body);
      if (jsonResponse is Map<String, dynamic>) {
        jsonResponse.forEach((key, treeData) {
          Tree tree = Tree.fromMap(treeData);
          treeList.add(tree);
        });

        notifyListeners();
      }
    } else {
      // Handle error
      print('Failed to load trees. Status code: ${result.statusCode}');
    }

    print(treeList);
  }

  Future<void> deleteTree(Tree tree) async {
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
              treeList.remove(tree);
              notifyListeners();
            } else {
              // Handle error
              print(
                  'Failed to delete tree. Status code: ${deleteResult.statusCode}');
            }

            break; // Stop searching once the tree is found and deleted
          }
        }
      }
    } else {
      // Handle error
      print('Failed to load trees. Status code: ${result.statusCode}');
    }
  }

  Future<void> createTree(String nom, String varietat, String tipus,
      bool autocton, String foto, String detall) async {
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
      // Retrieve the newly created tree from the response
      var jsonResponse = convert.jsonDecode(result.body);
      Tree newTree = Tree.fromMap(jsonResponse);

      // Add the new tree to the list
      treeList.add(newTree);
      notifyListeners();
    } else {
      // Handle error
      print('Failed to create tree. Status code: ${result.statusCode}');
    }
  }

  void clearTreeList() {
    treeList.clear();
    notifyListeners();
  }
}
