import 'package:flutter/material.dart';
import 'package:plantilla_login_register/providers/information.dart';
import 'package:provider/provider.dart';

class CreateTreeScreen extends StatefulWidget {
  @override
  _CreateTreeScreenState createState() => _CreateTreeScreenState();
}

class _CreateTreeScreenState extends State<CreateTreeScreen> {
  // Controladors per als camps de text
  final TextEditingController nomController = TextEditingController();
  final TextEditingController varietatController = TextEditingController();
  final TextEditingController tipusController = TextEditingController();
  bool isAutocton =
      false; // Utilitzem un booleà en lloc d'un TextEditingController
  final TextEditingController fotoController = TextEditingController();
  final TextEditingController detallController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Tree'), // Actualitzar el títol de la barra superior
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nomController,
              decoration: InputDecoration(labelText: 'Nom'),
            ),
            TextField(
              controller: varietatController,
              decoration: InputDecoration(labelText: 'Variedad'),
            ),
            TextField(
              controller: tipusController,
              decoration: InputDecoration(labelText: 'Tipus'),
            ),
            Row(
              children: [
                Text('Autocton:'),
                Switch(
                  value: isAutocton,
                  onChanged: (value) {
                    setState(() {
                      isAutocton = value;
                    });
                  },
                ),
              ],
            ),
            TextField(
              controller: fotoController,
              decoration: InputDecoration(labelText: 'URL de la Foto'),
            ),
            TextField(
              controller: detallController,
              decoration: InputDecoration(labelText: 'URL Detall'),
            ),
            // Afegir altres camps segons sigui necessari
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Crear un nou arbre i afegir-lo a Firebase
                Provider.of<Information>(context, listen: false).createTree(
                  nomController.text,
                  varietatController.text,
                  tipusController.text,
                  isAutocton,
                  fotoController.text,
                  detallController.text,
                );

                // Navegar de nou a la pantalla de la llista d'arbres
                Navigator.pop(context);
              },
              child: Text('Crear Arbre'),
            ),
          ],
        ),
      ),
    );
  }
}
