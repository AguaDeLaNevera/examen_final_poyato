import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:plantilla_login_register/models/tree.dart';

class TreeDetailsScreen extends StatelessWidget {
  // Funció per llançar una URL
  void launchURL(BuildContext context, String url) async {
    try {
      await launch(url);
    } catch (e) {
      // Gestionar l'error, per exemple, obrir una pantalla de detall per defecte
      Navigator.pushNamed(context, 'detall', arguments: {
        'treeDetall': url,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Recuperar les dades de l'arbre dels arguments
    final tree = ModalRoute.of(context)!.settings.arguments as Tree;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalls de larbre'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nom: ${tree.nom}'),
            Text('Varietat: ${tree.varietat}'),
            Text('Tipus: ${tree.tipus}'),
            Text('Autòcton: ${tree.autocton ? 'Sí' : 'No'}'),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // Llançar la URL quan s'ha clicat sobre la imatge
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
                // Navegar a una pantalla de detall quan es fa clic al botó
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
