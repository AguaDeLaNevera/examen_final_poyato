import 'package:flutter/material.dart';
import 'package:plantilla_login_register/providers/information.dart';
import 'package:provider/provider.dart';

class CreateUserScreen extends StatefulWidget {
  @override
  _CreateUserScreenState createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController photoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            TextField(
              controller: photoController,
              decoration: InputDecoration(labelText: 'Photo URL'),
            ),
            // Add other fields as needed
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Create a new user and add it to Firebase
                Provider.of<Information>(context, listen: false).createUser(
                  nameController.text,
                  emailController.text,
                  addressController.text,
                  phoneController.text,
                  photoController.text,
                );

                // Navigate back to the user list screen
                Navigator.pop(context);
              },
              child: Text('Create User'),
            ),
          ],
        ),
      ),
    );
  }
}
