import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:plantilla_login_register/models/tree.dart';

class TreeDetailsScreen extends StatelessWidget {
  // Function to launch URL
  void launchURL(BuildContext context, String url) async {
    try {
      await launch(url);
    } catch (e) {
      // Handle error, e.g., open a default detall screen
      Navigator.pushNamed(context, 'detall', arguments: {
        'treeDetall': url,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve the tree data from the arguments
    final tree = ModalRoute.of(context)!.settings.arguments as Tree;

    return Scaffold(
      appBar: AppBar(
        title: Text('Tree Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${tree.nom}'),
            Text('Variety: ${tree.varietat}'),
            Text('Type: ${tree.tipus}'),
            Text('Autocton: ${tree.autocton ? 'Yes' : 'No'}'),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // Launch URL when image is clicked
                launchURL(context, tree.detall);
              },
              child: Image.network(
                tree.foto,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to a detall screen when the button is clicked
                launchURL(context, tree.detall);
              },
              child: Text('Detall'),
            ),
          ],
        ),
      ),
    );
  }
}
