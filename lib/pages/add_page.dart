
import 'package:flutter/material.dart';
import 'package:todo_app_crud/pages/services/todo_service.dart';
import 'package:todo_app_crud/pages/utilis/snackbar_helper.dart';

class AddTodoPage extends StatefulWidget {
  final Map? todo;
  const AddTodoPage({super.key, this.todo});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();

  bool isEdit = false;
  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      final title = todo['title'];
      final description = todo['description'];
      titlecontroller.text = title;
      descriptioncontroller.text = description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 80, 84, 85),

      appBar: AppBar(
      backgroundColor: Color.fromARGB(255, 108, 109, 109),
      

        title: Text(isEdit ? 'Edit Todo' : "Add Todo", style: TextStyle(color: Colors.white70),),
      ),
      body: ListView(
      
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: titlecontroller,
            decoration: InputDecoration(
             
              
              hintText: 'Title'),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            
            controller: descriptioncontroller,
            decoration: InputDecoration(hintText: 'Description'),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: isEdit ? updateData : submitData,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(isEdit ? 'Update' : "Submit" , style: TextStyle(color: Colors.grey),),
              ))
        ],
      ),
    );
  }

  Future<void> updateData() async {
    final todo = widget.todo;
    if (todo == null) {
      print("You cannot call updated without todo data");
      return;
    }
    final id = todo['_id'];
    
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final isSuccess = await TodoService.updateTodo(id, body);
         if (isSuccess) {
      
      showSuccessMessage(context, message:"Updated");
    } else {
      showErrorMessage(context, message:"Failed");
    }
  }

  Future<void> submitData() async {
   
   
    final isSuccess = await TodoService.addTodo(body); 
    if (isSuccess) {
      titlecontroller.text = '';
      descriptioncontroller.text = '';
      showSuccessMessage(context, message:"Success");
    } else {
      showErrorMessage(context, message:'Failed');
    }
  }


  Map get body{
     final title = titlecontroller.text;
    final description = descriptioncontroller.text;
    return {
      "title": title,
      "description": description,
      "is_completed": false,
    };

  }

}
