// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:to_do_it/screens/task_form.dart'; // Change 'your_app_name' to your actual app name
import '../models/task.dart';
import '../services/local_storage_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  _loadTasks() async {
    List<Task> tasks = await LocalStorageService.getTasks();
    setState(() {
      _tasks = tasks;
    });
  }

  _addTask() async {
    final newTask = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskForm()),
    );
    if (newTask != null) {
      setState(() {
        _tasks.add(newTask);
      });
      LocalStorageService.saveTasks(_tasks);
    }
  }

  _editTask(Task task) async {
    final updatedTask = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskForm(task: task)),
    );
    if (updatedTask != null) {
      setState(() {
        int index = _tasks.indexOf(task);
        _tasks[index] = updatedTask;
      });
      LocalStorageService.saveTasks(_tasks);
    }
  }

  _deleteTask(Task task) {
    setState(() {
      _tasks.remove(task);
    });
    LocalStorageService.saveTasks(_tasks);
  }

  _reorderTasks(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex -= 1;
      final Task task = _tasks.removeAt(oldIndex);
      _tasks.insert(newIndex, task);
    });
    LocalStorageService.saveTasks(_tasks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logotdi.png', height: 80), // Display logo
            SizedBox(width: 0),

          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.blue.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: _tasks.isEmpty
            ? Center(
          child: Text(
            'No tasks available. Please add some!',
            style: TextStyle(fontSize: 18),
          ),
        )
            : ReorderableListView.builder(
          itemCount: _tasks.length,
          onReorder: _reorderTasks,
          itemBuilder: (context, index) {
            final task = _tasks[index];
            return Card(
              key: ValueKey(task), // Key for draggable item
              margin: EdgeInsets.all(10),
              child: ListTile(
                title: Text(
                  task.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.description),
                    Text('Due: ${task.dueDate.toLocal().toString().split(' ')[0]}'), // Display date only
                    Text('Priority: ${task.priority}'), // Display priority
                  ],
                ),
                trailing: Checkbox(
                  value: task.isCompleted,
                  onChanged: (bool? value) {
                    setState(() {
                      task.isCompleted = value!;
                    });
                    LocalStorageService.saveTasks(_tasks);
                  },
                ),
                onTap: () => _editTask(task),
                onLongPress: () => _deleteTask(task),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: Icon(Icons.add),
      ),
    );
  }
}
