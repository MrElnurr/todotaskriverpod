import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/all_providers.dart';

class TodoListItemWidget extends ConsumerStatefulWidget {
  const TodoListItemWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      TodoListItemWidgetState();
}

class TodoListItemWidgetState extends ConsumerState<TodoListItemWidget> {
  @override
  Widget build(BuildContext context) {
    final currentTodoItem = ref.watch(currentTodoProvider);
    return ListTile(
      leading: Checkbox(
        value: currentTodoItem.completed,
        onChanged: (value) {
          ref.read(todoListProvider.notifier).toggle(currentTodoItem.id);
        },
      ),
      title: SizedBox(
        height: 40,
        child: Card(
            child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 3),
          child: Text(
            style: const TextStyle(fontSize: 20),
            currentTodoItem.description,
          ),
        )),
      ),
    );
  }
}
