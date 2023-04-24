import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/Reusable_Components/reusable_widgets.dart';
import '../Cubit/cubit.dart';
import '../Cubit/states.dart';

class ArchivedTasksScreen extends StatelessWidget {
  const ArchivedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        AppCubit cubit=AppCubit.get(context);
        return ListView.builder(
          itemCount: cubit.archivedTasks.length,
          itemBuilder:(context,index){
            return ItemListBuilder(
              context: context,
              map: cubit.archivedTasks[index],
            );
          },
        );
      },
    );
  }
}
