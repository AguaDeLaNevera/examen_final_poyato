import 'package:flutter/material.dart';
import 'package:plantilla_login_register/models/user.dart';

class UserDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve the user data from the arguments
    final user = ModalRoute.of(context)!.settings.arguments as User;

    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${user.name}'),
            Text('Email: ${user.email}'),
            Text('Address: ${user.address}'),
            Text('Phone: ${user.phone}'),
            // Add other fields as needed
            SizedBox(height: 20),
            Image.network(
              user.photo,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
