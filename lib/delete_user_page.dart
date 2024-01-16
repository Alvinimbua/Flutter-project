import 'package:flutter/material.dart';
import 'httpservice.dart'; 
import 'user.dart'; 

class DeleteUserDialog extends StatelessWidget {
  final VoidCallback onDeleteConfirmed;
  

  DeleteUserDialog({required this.onDeleteConfirmed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm Deletion'),
      content: const Text('Are you sure you want to delete this user?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            onDeleteConfirmed(); // Call the provided callback to delete the user
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Confirm'),
        ),
      ],
    );
  }
}
