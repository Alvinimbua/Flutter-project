import 'package:flutter/material.dart';
import 'user.dart';
import 'httpservice.dart';
import 'create_user_page.dart';

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final UserService userService = UserService('http://localhost:3000');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User CRUD App'),
      ),
      body: FutureBuilder<List<User>>(
        future: userService.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final users = snapshot.data ?? [];
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) => ListTile(
                title: Text('First Name: ${users[index].firstName}, Last Name: ${users[index].lastName}, Email: ${users[index].email}'),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateUserPage(userService),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}