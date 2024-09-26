// lib/screens/task_form.dart
import 'package:flutter/material.dart';
import '../models/task.dart';
import 'package:intl/intl.dart'; // Import intl package for date formatting

class TaskForm extends StatefulWidget {
  final Task? task;

  TaskForm({this.task});

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _dueDate;
  String _selectedPriority = 'Normal'; // Default priority

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      _dueDate = widget.task!.dueDate;
      _selectedPriority = widget.task!.priority; // Set selected priority
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'New Task' : 'Edit Task', style: TextStyle(fontWeight: FontWeight.bold)), // Bold title
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView( // Allows scrolling if the keyboard opens
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, // Center align the contents
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: TextStyle(fontWeight: FontWeight.bold), // Bold label
                  ),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(fontWeight: FontWeight.bold), // Bold label
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_dueDate == null
                        ? 'Select due date'
                        : 'Due: ${DateFormat('yyyy-MM-dd').format(_dueDate!)}'), // Format date
                    TextButton(
                      child: Text('Pick Date'),
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: _dueDate ?? DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _dueDate = pickedDate;
                          });
                        }
                      },
                    )
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Priority:', style: TextStyle(fontWeight: FontWeight.bold)), // Bold label
                    SizedBox(width: 10), // Add spacing
                    DropdownButton<String>(
                      value: _selectedPriority,
                      items: ['High', 'Medium', 'Low', 'Normal'].map((String priority) {
                        return DropdownMenuItem<String>(
                          value: priority,
                          child: Text(priority),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedPriority = newValue ?? 'Normal';
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green), // Set button color to green
                  child:
                  Text('Save Task'),
                  onPressed: () {
                    final task = Task(
                      title: _titleController.text,
                      description: _descriptionController.text,
                      dueDate: _dueDate ?? DateTime.now(),
                      priority: _selectedPriority,
                    );
                    Navigator.pop(context, task);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
