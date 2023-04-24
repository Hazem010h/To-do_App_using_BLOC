import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/reusable_widgets.dart';
import 'package:todo_bloc/states.dart';

import 'cubit.dart';

class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        AppCubit cubit=AppCubit.get(context);
        return ListView.builder(
          itemCount: cubit.doneTasks.length,
          itemBuilder:(context,index){
            return ItemListBuilder(
              context: context,
              map: cubit.doneTasks[index],
            );
          },
        );
      },
    );
  }
}
