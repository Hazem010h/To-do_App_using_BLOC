import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_bloc/Cubit/states.dart';
import 'package:todo_bloc/Screens/done_screen.dart';
import 'package:todo_bloc/Screens/new_screen.dart';
import 'package:todo_bloc/Reusable_Components/reusable_widgets.dart';
import '../Screens/archived_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  Database? database;

  List<Map> newTasks=[];
  List<Map> doneTasks=[];
  List<Map> archivedTasks=[];

  DateTime date=DateTime.now();
  TimeOfDay time=TimeOfDay.now();


  TextEditingController titleController = TextEditingController(text: 'New Task');
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  int currentIndex = 0;
  Icon fabIcon = const Icon(Icons.add);
  List<Widget> screens = [
    const NewTasksScreen(),
    const DoneTasksScreen(),
    const ArchivedTasksScreen(),
  ];

  static AppCubit get(context) => BlocProvider.of(context);

  Future<void> createDatabase() async {
     database = await openDatabase('todo', version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE tasks ('
                  'id INTEGER PRIMARY KEY,'
                  ' title TEXT,'
                  ' date TEXT,'
                  ' time TEXT,'
                  ' status TEXT'
                  ')'
          );
          emit(AppDatabaseCreatedState());
        },
     onOpen: (value){
       database=value;
       emit(AppDatabaseOpenedState());
       getRecords();
     },
     );
  }

  Future<void> insertRecords({
    required String title,
    required String date,
    required String time,
}) async {
    await database!.transaction((txn) async {
      int id = await txn.rawInsert(
          'INSERT INTO tasks(title, date, time,status) VALUES("${title}", "${date}", "${time}", "new")');
      emit(AppDatabaseInsertRecordsState());
      print('inserted: $id');
      getRecords();

    });
  }

  void updateRecord({
    required int id,
    required String status,
}){
     database!.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        ['$status',id]).then((value){
          emit(AppDatabaseUpdateRecordsState());
          getRecords();
     });
  }

  void deleteRecord({
    required int id,
}){
     database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value){
       emit(AppDatabaseDeleteRecordsState());
       getRecords();
     });
  }

  void getRecords(){
    newTasks=[];
    doneTasks=[];
    archivedTasks=[];
    database!.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if(element['status']=='new'){
          newTasks.add(element);
        }else if(element['status']=='done'){
          doneTasks.add(element);
        }else{
          archivedTasks.add(element);
        }
      });
      emit(AppDatabaseGetRecordsState());
      print(newTasks.toString());
      print(doneTasks.toString());
      print(archivedTasks.toString());
    });
  }

  void changeScreen(int index) {
    currentIndex = index;
    emit(AppChangeScreenState());
  }

  void AssignDateTime(){
    dateController.text='${date.day}/${date.month}/${date.year}';
    timeController.text='${time.hour}:${time.minute}';
  }

  void FabPressed({
    context,
  }) {
    AssignDateTime();
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ReusableTextFormField(
                          onTap: () {},
                          label: const Text('Title'),
                          controller: titleController,
                        ),
                        ReusableTextFormField(
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: date,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(3000),
                            ).then((value) {
                              if(value !=null){
                                date=value;
                                AssignDateTime();
                                emit(AppChangeDateState());
                              }
                            });
                            FocusScope.of(context).requestFocus( FocusNode());
                          },
                          label: const Text('Date'),
                          controller: dateController,
                        ),
                        ReusableTextFormField(
                          onTap: () {
                            showTimePicker(
                                context: context,
                                initialTime: time
                            ).then((value) {
                              if(value!=null){
                                time=value;
                                AssignDateTime();
                                emit(AppChangeTimeState());
                              }
                            });
                            FocusScope.of(context).requestFocus( FocusNode());
                          },
                          label: const Text('Time'),
                          controller: timeController,
                        ),
                        TextButton(onPressed: (){
                          insertRecords(
                              title: titleController.text,
                              date: dateController.text,
                              time: timeController.text,
                          ).then((value) {
                            Navigator.pop(context);
                          });
                        },
                            child: const Text('SUBMIT'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
          });
  }
}
