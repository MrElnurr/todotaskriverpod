import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoriverpod/providers/all_providers.dart';
import 'package:todoriverpod/widgets/list_items_widget.dart';
import 'package:todoriverpod/widgets/toolbar_widget.dart';

class MyHomeScreen extends ConsumerWidget {
  MyHomeScreen({Key? key}) : super(key: key);

  final newTodoController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var allTodos = ref.watch(filteredTodoList);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 35),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: [
            TextField(
              controller: newTodoController,
              decoration: const InputDecoration(
                  labelText: 'Add Todo',
                  labelStyle: TextStyle(color: Colors.red),
                  border: OutlineInputBorder()),
              onSubmitted: (newTodo) {
                if (newTodo.isEmpty) {
                  showAlertDialog(context);

                  ref.read(todoListProvider.notifier).addTodo(newTodo);
                }
              },
            ),
            Padding(
                padding: const EdgeInsets.only(top: 37),
                child: ToolBarWidget()),
            if (allTodos.isEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Center(
                  child: Text(
                    'Empty',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            else
              const SizedBox(),
            for (var i = 0; i < allTodos.length; i++)
              Dismissible(
                key: ValueKey(allTodos[i].id),
                onDismissed: (_) {
                  ref.read(todoListProvider.notifier).remove(allTodos[i]);
                },
                child: ProviderScope(
                  overrides: [
                    currentTodoProvider.overrideWithValue(allTodos[i]),
                  ],
                  child: const TodoListItemWidget(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

void showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: const Text('Write Something'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
