
import 'package:flutter/material.dart';
import 'package:todo_app_crud/pages/todo_list.dart';

void main() {
  runApp(  MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Flutter Demo',

      // theme: Provider.of<ThemeProvider>(context).themeData,
      theme: ThemeData.dark(),


      // theme: ThemeData(
        
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
      // ),
      home: TodoListPage(),
    );
  }
}

