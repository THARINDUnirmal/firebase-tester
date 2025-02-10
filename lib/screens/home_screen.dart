import 'package:first_fire_base_app/models/task_model.dart';
import 'package:first_fire_base_app/services/database_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          title: Text(
            "Add Task !",
            style: GoogleFonts.lato(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: TextField(
            maxLines: 1,
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
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(
                Colors.lightGreenAccent,
              )),
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
                style: TextStyle(
                  color: Colors.black,
                ),
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
          style: GoogleFonts.lobster(
            fontSize: 40,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: DatabaseServices().fetchAllTask(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error : ${snapshot.error}"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text("No data found !"),
            );
          } else {
            final List<TaskModel> data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                TaskModel indexData = data[index];
                return Card(
                  child: ListTile(
                    title: Text(
                      maxLines: 3,
                      indexData.name,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    subtitle: Text(
                      indexData.createDate.toString(),
                    ),
                    trailing: IconButton(
                      onPressed: () async {
                        await DatabaseServices().deleteData(indexData.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.blueAccent,
                            duration: Duration(
                              seconds: 2,
                            ),
                            content: Text(
                              "Data delete successfull !",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.delete_outline,
                        size: 30,
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openDialogBox,
        child: Center(
          child: Icon(
            Icons.add,
            size: 30,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
