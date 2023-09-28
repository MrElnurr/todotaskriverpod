import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/all_providers.dart';

// ignore: must_be_immutable
class ToolBarWidget extends ConsumerWidget {
  ToolBarWidget({Key? key}) : super(key: key);
  var currentFilter = TodoListFilter.all;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onCompletedTodoCount = ref.watch(unCompletedTodoCount);
    currentFilter = ref.watch(todoListFilter);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            onCompletedTodoCount == 0
                ? 'Finished'
                : "$onCompletedTodoCount In Progress",
          ),
        ),
        Tooltip(
          message: 'All Todos',
          child: TextButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                    Color.fromARGB(255, 236, 234, 234)),
                elevation: MaterialStatePropertyAll(4),
              ),
              onPressed: () {
                ref.read(todoListFilter.notifier).state = TodoListFilter.all;
              },
              child: const Text('All')),
        ),
        const SizedBox(
          width: 13,
        ),
        Tooltip(
          message: 'Active Todos',
          child: TextButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                    Color.fromARGB(255, 236, 234, 234)),
                elevation: MaterialStatePropertyAll(4),
              ),
              onPressed: () {
                ref.read(todoListFilter.notifier).state = TodoListFilter.active;
              },
              child: const Text('In Progress')),
        ),
        const SizedBox(
          width: 13,
        ),
        Tooltip(
          message: 'Completed Todos',
          child: TextButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                    Color.fromARGB(255, 236, 234, 234)),
                elevation: MaterialStatePropertyAll(4),
              ),
              onPressed: () {
                ref.read(todoListFilter.notifier).state =
                    TodoListFilter.completed;
              },
              child: const Text('Completed')),
        ),
      ],
    );
  }
}
