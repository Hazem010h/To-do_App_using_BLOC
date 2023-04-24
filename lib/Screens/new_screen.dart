import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/Cubit/cubit.dart';
import 'package:todo_bloc/Reusable_Components/reusable_widgets.dart';

import '../Cubit/states.dart';

class NewTasksScreen extends StatelessWidget {
  const NewTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        AppCubit cubit=AppCubit.get(context);
        return ListView.builder(
          itemCount: cubit.newTasks.length,
            itemBuilder:(context,index){
              return ItemListBuilder(
                context: context,
                map: cubit.newTasks[index],
              );
            },
        );
      },
    );
  }
}
