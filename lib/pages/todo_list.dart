import 'package:flutter/material.dart';
import 'package:todo_app_crud/pages/add_page.dart';
import 'package:todo_app_crud/pages/services/todo_service.dart';
import 'package:todo_app_crud/pages/utilis/snackbar_helper.dart';
import 'package:todo_app_crud/widgets/todo_card.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  bool isLoading = true;
  List items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 80, 84, 85),
      appBar: AppBar(
      backgroundColor: Color.fromARGB(255, 108, 109, 109),

        title: Text("Todo List", style: TextStyle(color: Colors.white70),),
        
      ),
      body: Visibility(
        visible: isLoading,
        child: Center(
          child: CircularProgressIndicator(),
        ),
        replacement: RefreshIndicator(
          onRefresh: fetchTodo,
          child: Visibility(
            visible: items.isNotEmpty,
            replacement: Center(
              child: Text(
                "No todo item",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            child: ListView.builder(
                itemCount: items.length,
                padding: EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  final item = items[index] as Map;
                  final id = item['_id'] as String;

                  return TodoCard(
                      index: index,
                      item: item,
                      navigateEdit: navigateToEditPage,
                      deleteById: deleteById);
                }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: navigateToAddPage, label: Text("Add a task")),
    
    );
  }

  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(builder: (context) => AddTodoPage());
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> navigateToEditPage(Map item) async {
    final route =
        MaterialPageRoute(builder: (context) => AddTodoPage(todo: item));
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> deleteById(String id) async {
    final isSuccess = await TodoService.deleteById(id);
    if (isSuccess) {
      final filtered = items.where((element) => element['_id'] != id).toList();
      setState(() {
        items = filtered;
      });
    } else {
      showErrorMessage(context, message: 'Unable to delete');
    }
  }

  Future<void> fetchTodo() async {
    final response = await TodoService.fetchTodos();
    if (response != null) {
      setState(() {
        items = response;
      });
    } else {
      showErrorMessage(context, message: 'Somerthing went wrong');
    }
    setState(() {
      isLoading = false;
    });
  }
}
