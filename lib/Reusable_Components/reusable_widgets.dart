import 'package:flutter/material.dart';
import 'package:todo_bloc/Cubit/cubit.dart';

Widget ReusableTextFormField({
  required Widget label,
  required void Function() onTap,
  required TextEditingController controller,
})=>Padding(
  padding: const EdgeInsets.fromLTRB(8,5,8,5),
  child:   TextFormField(
    controller: controller,
    onTap: onTap,
    decoration: InputDecoration(
      enabledBorder: const OutlineInputBorder(),
      label: label,
      focusedBorder:OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue, width: 2.0),
        borderRadius: BorderRadius.circular(25.0),
      ),
    ),
  ),
);

Widget ItemListBuilder({
  required map,
  required context,
}){
  return Dismissible(
    onDismissed: (direction){
      AppCubit.get(context).deleteRecord(id: map['id']);
    },
    key: Key(map['id'].toString()),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(8,8,5,0),
      child: Row(
        children: [
          Text(
              '${map['title']}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const Spacer(),
          Column(
            children: [
              Text('Time: ${map['time']}'),
              Text('Date: ${map['date']}'),
            ],
          ),
          const Spacer(),
          IconButton(
              onPressed: (){
                AppCubit.get(context).updateRecord(
                    id: map['id'],
                    status: 'done',
                );
              },
              icon: const Icon(Icons.check),
          ),
          IconButton(
            onPressed: (){
              AppCubit.get(context).updateRecord(
                id: map['id'],
                status: 'archived',
              );
            },
            icon: const Icon(Icons.archive_rounded),
          ),
        ],
      ),
    ),
  );
}