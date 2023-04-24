import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/cubit.dart';
import 'package:todo_bloc/states.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context)=>AppCubit()..createDatabase(),
        child: BlocConsumer<AppCubit,AppStates>(
          listener: (context,state){},
          builder: (context,state){
            AppCubit cubit=AppCubit.get(context);
            // cubit.createDatabase();
            return Scaffold(
            appBar: AppBar(
              title: const Text('TODO BLOC APP'),
              centerTitle: true,
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.menu),
                    label:'New Tasks',
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline_rounded),
                    label:'Done Tasks',
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_rounded),
                    label:'Archived Tasks',
                ),
              ],
              currentIndex: cubit.currentIndex,
              onTap: (int index){
                cubit.changeScreen(index);
              },
            ),
              floatingActionButton: FloatingActionButton(
                onPressed: (){
                  cubit.FabPressed(context: context);
                },
                child: cubit.fabIcon,
              ),
          );
          }
        ),
    );
  }
}
