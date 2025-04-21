import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class EmployeeForm extends StatefulWidget {
  const EmployeeForm({super.key});

  @override
  State<EmployeeForm> createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> {
  final _nameController = TextEditingController();
  final _positionController = TextEditingController();

  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref().child('employees');

  void _saveEmployee() {
    String name = _nameController.text.trim();
    String position = _positionController.text.trim();

    if (name.isNotEmpty && position.isNotEmpty) {
      String id = _dbRef.push().key!;
      _dbRef.child(id).set({
        'name': name,
        'position': position,
      }).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Employee added!")),
        );
        _nameController.clear();
        _positionController.clear();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $error")),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Employee")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _positionController,
              decoration: const InputDecoration(labelText: 'Position'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveEmployee,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
