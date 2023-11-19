import 'package:flutter/material.dart';
import 'modules/todo/views/todo_view.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter VIPER Todo',
    home: TodoView(),
    debugShowCheckedModeBanner: false,
  ));
}
