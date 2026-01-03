import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Todo')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              hintText: 'Enter Todo Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
              hintText: 'Enter Todo Description',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: submitData, child: const Text('Save Todo')),
        ],
      ),
    );
  }

  Future<void> submitData() async {
    String title = titleController.text;
    String description = descriptionController.text;
    print(title);
    print(description);
    // Further processing like saving the data
    Map<String, dynamic> payload = {
      "title": title,
      "description": description,
      "is_completed": false,
    };
    print(payload);

    var url = Uri.http('10.0.2.2:3000', '/todos');
    var response = await http.post(
      url,
      body: jsonEncode(payload),
      headers: {"Content-Type": "application/json"},
    );
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 201) {
      print('Todo created successfully!');
      successMessage();
    } else {
      print('Failed to create todo.');
      failMessage();
    }

    print('Response body: ${response.body}');
    titleController.text = '';
    descriptionController.text = '';

    //
  }

  //

  //
  void successMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Todo Added Successfully',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green, // Green for success
        duration: Duration(seconds: 2),
      ),
    );
  }

  void failMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Todo Failed', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red, // Red for failure
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
  //

  //
}
