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
    print('Response body: ${response.body}');

    //
  }
}
