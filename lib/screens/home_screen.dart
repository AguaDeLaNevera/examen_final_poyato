import 'package:flutter/material.dart';
import 'package:plantilla_login_register/models/tree.dart'; // Import the Tree class
import 'package:plantilla_login_register/providers/information.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Information info = Provider.of<Information>(context);
    List<Tree> treeList = info.treeList; // Use treeList instead of userList

    Future<void> _refreshTreeList() async {
      // Clear the tree list
      info.clearTreeList();

      // Fetch new tree data
      await info.getTrees();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Tree List'), // Update the title
      ),
      body: RefreshIndicator(
        onRefresh: _refreshTreeList,
        child: treeList.isEmpty
            ? Center(
                child: Text('No trees available'), // Update the message
              )
            : ListView.builder(
                itemCount: treeList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(treeList[index].nom), // Update property access
                    subtitle: Text(treeList[index].varietat),
                    onTap: () {
                      // Navigate to tree details screen
                      Navigator.pushNamed(
                        context,
                        'treeDetails', // Assuming you have a route named 'treeDetails'
                        arguments: treeList[index],
                      );
                    },
                    onLongPress: () {
                      // Show a dialog to confirm tree deletion
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Delete Tree'),
                            content: Text(
                                'Are you sure you want to delete this tree?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Delete the tree
                                  info.deleteTree(treeList[index]);
                                  Navigator.of(context).pop();
                                },
                                child: Text('Delete'),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the screen to create a new tree
          Navigator.pushNamed(context,
              'createTree'); // Assuming you have a route named 'createTree'
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
