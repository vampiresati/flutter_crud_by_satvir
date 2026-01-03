import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_crud_app/screens/add_list.dart';

import 'package:http/http.dart' as http;

class TodoList extends StatefulWidget {
  const TodoList({super.key});
  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Map<String, dynamic>> items = [];
  // Navigation function has access to context
  @override
  void initState() {
    super.initState();
    fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List 2024')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final todo = items[index];

          final bool isCompleted = todo['is_completed'] == true;

          return ListTile(
            title: Text(todo['title'] ?? ''),
            subtitle: Text(todo['description'] ?? ''),
            trailing: Icon(
              isCompleted ? Icons.check_circle : Icons.circle_outlined,
              color: isCompleted ? Colors.green : Colors.grey,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigatetoaddpage,
        child: const Icon(Icons.add),
      ),
    );
  }

  void navigatetoaddpage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTodo()),
    );
  }

  //
  Future<List<Map<String, dynamic>>> fetchTodos() async {
    try {
      var url = Uri.http('10.0.2.2:3000', '/todos'); // Android emulator
      var response = await http.get(url);

      if (response.statusCode == 200) {
        // Decode JSON
        List<dynamic> data = jsonDecode(response.body);
        // Convert dynamic to Map<String, dynamic>
        List<Map<String, dynamic>> todos = List<Map<String, dynamic>>.from(
          data,
        );

        setState(() {
          // Update your state with the fetched todos if needed
          items = todos;
        });

        return todos;
      } else {
        print('Failed to fetch todos. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching todos: $e');
      return [];
    }
  }

  //
}
