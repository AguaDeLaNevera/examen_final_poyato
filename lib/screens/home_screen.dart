import 'package:flutter/material.dart';
import 'package:plantilla_login_register/models/user.dart';
import 'package:plantilla_login_register/providers/information.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Information info = Provider.of<Information>(context);
    List<User> userList = info.userList;

    Future<void> _refreshUserList() async {
      // Clear the user list
      info.clearUserList();

      // Fetch new user data
      await info.getUsers();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshUserList,
        child: userList.isEmpty
            ? Center(
                child: Text('No users available'),
              )
            : ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(userList[index].name),
                    subtitle: Text(userList[index].email),
                    onTap: () {
                      // Navigate to user details screen
                      Navigator.pushNamed(
                        context,
                        'userDetails',
                        arguments: userList[index],
                      );
                    },
                    onLongPress: () {
                      // Show a dialog to confirm user deletion
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Delete User'),
                            content: Text(
                                'Are you sure you want to delete this user?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Delete the user
                                  info.deleteUser(userList[index]);
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
          // Navigate to the screen to create a new user
          Navigator.pushNamed(context, 'createUser');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
