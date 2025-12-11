import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  late Future<List<dynamic>> futureTodos;

  @override
  void initState() {
    super.initState();
    futureTodos = fetchTodos();
  }

  Future<List<dynamic>> fetchTodos() async {
    var url = Uri.parse("https://dummyjson.com/todos");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data["todos"]; 
    } else {
      throw Exception("Gagal memuat data Todo");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
        backgroundColor: Colors.blue.shade100,
      ),

      body: FutureBuilder<List<dynamic>>(
        future: futureTodos,
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          var todos = snapshot.data!;

          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              var item = todos[index];
              bool completed = item["completed"];

              return ListTile(
                title: Text(
                  item["todo"], 
                  style: TextStyle(
                    color: completed ? Colors.green : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: Icon(
                  completed ? Icons.check_circle : Icons.cancel,
                  color: completed ? Colors.green : Colors.red,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
