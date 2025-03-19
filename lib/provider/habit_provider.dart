import 'package:flutter/material.dart';

import '../model/habit_model.dart';

class HabitProvider with ChangeNotifier {
  final List<Habit> _habits = [];

  List<Habit> get habits => _habits;
  int get totalHabits => _habits.length;
  int get totalHabitsDone => _habits.where((habit) => habit.isDone).length;
  double get progress => totalHabits == 0 ? 0 : (totalHabitsDone / totalHabits)*100;

  void addHabit(String title) {
    final newHabit = Habit(
      id: DateTime.now().toString(),
      title: title,
    );

    _habits.add(newHabit);
    notifyListeners();
  }

  void toggleHabit(String id) {
    final habitIndex = _habits.indexWhere((habit) => habit.id == id);
    _habits[habitIndex].isDone = !_habits[habitIndex].isDone;
    notifyListeners();
  }

  void resetHabits() {
    for (var habit in _habits) {
      habit.isDone = false;
    }
  }

  void deleteHabit(String id) {
    _habits.removeWhere((habit) => habit.id == id);
    notifyListeners();
  }
}