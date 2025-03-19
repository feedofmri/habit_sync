import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/habit_provider.dart';

class HabitList extends StatelessWidget {
  const HabitList({super.key});

  @override
  Widget build(BuildContext context) {
    final habitProvider = Provider.of<HabitProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('HabitSync'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              habitProvider.resetHabits();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Daily Progress ${habitProvider.totalHabitsDone}/${habitProvider.totalHabits}', style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 10),
                  LinearProgressIndicator(
                    value: habitProvider.progress / 100,
                  ),
                  const SizedBox(height: 10),
                  Text('Completion Rate: %${habitProvider.progress.toStringAsFixed(1)}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              )
          ),

          Expanded(
            child: ListView.builder(
              itemCount: habitProvider.totalHabits,
              itemBuilder: (context, index) {
                final habit = habitProvider.habits[index];
                return GestureDetector(
                  onLongPress: () {
                    habitProvider.deleteHabit(habit.id);
                  },
                  child: ListTile(
                    title: Text(habit.title),
                    trailing: Checkbox(
                      value: habit.isDone,
                      onChanged: (value) {
                        habitProvider.toggleHabit(habit.id);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              final TextEditingController controller = TextEditingController();
              return AlertDialog(
                title: const Text('Add Habit'),
                content: TextField(
                  controller: controller,
                  decoration: const InputDecoration(hintText: 'Enter habit'),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (controller.text.isNotEmpty) {
                        habitProvider.addHabit(controller.text);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
