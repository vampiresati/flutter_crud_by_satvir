import 'package:flutter/material.dart';
import 'package:todo_crud_app/screens/add_list.dart';

import 'package:flutter/material.dart';
import 'package:todo_crud_app/screens/add_list.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  // Navigation function has access to context

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List 2024')),
      body: const Center(child: Text('This is the Todo List Screen')),
      floatingActionButton: FloatingActionButton(
        onPressed: navigatetoaddpage, // Works now
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
}
