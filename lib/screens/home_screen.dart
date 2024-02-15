import 'package:flutter/material.dart';
import 'package:plantilla_login_register/models/tree.dart'; // Importa la classe Tree
import 'package:plantilla_login_register/providers/information.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtenir una instància del proveïdor d'informació
    Information info = Provider.of<Information>(context);

    // Obté la llista d'arbres des del proveïdor (informació)
    List<Tree> treeList = info.treeList;

    // Funció per refrescar la llista d'arbres
    Future<void> _refreshTreeList() async {
      // Esborrar la llista d'arbres existent
      info.clearTreeList();

      // Obtindre noves dades d'arbres
      await info.getTrees();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Llista darbres'), // Actualitza el títol de la pantalla
      ),
      body: RefreshIndicator(
        onRefresh: _refreshTreeList,
        child: treeList.isEmpty
            ? Center(
                child: Text(
                    'No hi ha arbres disponibles'), // Actualitza el missatge
              )
            : ListView.builder(
                itemCount: treeList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(treeList[index]
                        .nom), // Actualitza l'accés a les propietats
                    subtitle: Text(treeList[index].varietat),
                    onTap: () {
                      // Navegar a la pantalla de detalls de l'arbre
                      Navigator.pushNamed(
                        context,
                        'treeDetails', // Suposant que tens una ruta anomenada 'treeDetails'
                        arguments: treeList[index],
                      );
                    },
                    onLongPress: () {
                      // Mostrar un diàleg per confirmar la eliminació de l'arbre
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Eliminar arbre'),
                            content:
                                Text('Segur que vols eliminar aquest arbre?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel·lar'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Eliminar l'arbre
                                  info.deleteTree(treeList[index]);
                                  Navigator.of(context).pop();
                                },
                                child: Text('Eliminar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              // Navegar a la pantalla per crear un nou arbre
              Navigator.pushNamed(context,
                  'createTree'); // Suposant que tens una ruta anomenada 'createTree'
            },
            child: Icon(Icons.add),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              // Navegar a la pantalla de geolocalització d'IP
              Navigator.pushNamed(context, 'ipGeolocation');
            },
            child: Icon(Icons.location_on),
          ),
        ],
      ),
    );
  }
}
