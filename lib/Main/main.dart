import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_bloc/Screens/layout.dart';

import '../Cubit/bloc_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LayoutScreen(),
    );
  }
}

