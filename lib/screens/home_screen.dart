import 'package:first_fire_base_app/services/database_services.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameContraller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameContraller.dispose();
  }

  void openDialogBox() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Task !"),
          content: TextField(
            controller: _nameContraller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await DatabaseServices().addTask(_nameContraller.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.blueAccent,
                    duration: Duration(
                      seconds: 3,
                    ),
                    content: Text(
                      "Data Added !",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
                _nameContraller.clear();

                Navigator.pop(context);
              },
              child: Text(
                "Submit",
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Close",
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Task App",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openDialogBox,
        child: Center(
          child: Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}
