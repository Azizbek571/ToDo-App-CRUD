import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  final int index;
  final Map item;
  final Function (Map) navigateEdit;
  final Function (String) deleteById;
  const TodoCard({super.key,
   required this.index,
   required this.item,
   required this.navigateEdit,
   required this.deleteById,
   });

  @override
  Widget build(BuildContext context) {
    
    final id = item['_id'] as String;
    return    Card(
      
                    child: ListTile(
                      
                      leading: CircleAvatar(child: Text('${index + 1}')),
                      title: Text(item['title'], style: TextStyle(color: Colors.white70),),
                      subtitle: Text(item['description'], style: TextStyle(color: Colors.white70)),
                      trailing: PopupMenuButton(onSelected: (value) {
                        if (value == 'edit') {
                          navigateEdit(item);
                        } else if (value == 'delete') {
                          deleteById(id);
                        }
                      }, itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            child: Text("Edit"),
                            value: 'edit',
                          ),
                          PopupMenuItem(
                            child: Text("Delete"),
                            value: 'delete',
                          ),
                        ];
                      }),
                    ),
                  );


  }
}