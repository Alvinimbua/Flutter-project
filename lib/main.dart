//import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app_washington/httpservice.dart';
import 'package:flutter_app_washington/user.dart';
import 'package:http/http.dart' as http;
import './user_list_page.dart';
import './update_user_page.dart';
import './delete_user_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String healthStatus = '';

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/api/health'));

      if (response.statusCode == 200) {
        setState(() {
          healthStatus = response.body.toString();
        });
      } else {
        setState(() {
          healthStatus = 'Error: ${response.statusCode}';
        });
      }
    } catch (error) {
      setState(() {
        healthStatus = 'Error: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    UserService userServiceInstance = UserService('http://localhost:3000');
    User userInstance = User(id: 'userId', firstName: 'John', lastName: 'Doe', email: 'john.doe@example.com');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Node.js API Washington'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                fetchData();
              },
              child: const Text('Fetch Data'),
            ),
            const SizedBox(height: 20),
            Text('Health Status: $healthStatus'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserListPage()),
                );
              },
              child: const Text('Go To User List'),

            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                     MaterialPageRoute(builder: (context) => UpdateUserPage(userService: userServiceInstance, user: userInstance)),
                );
              },
              child: const Text('Go To Update User List'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return DeleteUserDialog(
                      onDeleteConfirmed: () async {
                       
                        try {
                          await userServiceInstance.deleteUser(userInstance.id);
                          
                          print('User deleted successfully');
                        } catch (error) {
                          
                          print('Failed to delete user: $error');
                        }
                      },
                    );
                  },
                );
              },
              child: const Text('Delete User'),
),
            
              
          ],
        ),
      ),
    );
  }


}

