// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'package:diary_app/api/diary_api.dart';
import 'package:flutter/material.dart';
import '../model.dart';
import 'home.dart';

class UpdateEntryScreen extends StatefulWidget {
  final Diary entry;
  const UpdateEntryScreen({super.key, required this.entry});

  @override
  State<UpdateEntryScreen> createState() => _UpdateEntryScreenState();
}

class _UpdateEntryScreenState extends State<UpdateEntryScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  late final Diary entry;
  @override
  void initState() {
    entry = widget.entry;
    bodyController.text = entry.body;
    titleController.text = entry.title;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Diary Entry"),
        actions: [
          OutlinedButton(
            onPressed: () async {
              if (titleController.text.isNotEmpty &&
                  bodyController.text.isNotEmpty) {
                entry.body = bodyController.text;
                entry.title = titleController.text;
                var a = await updateEntry(entry);
                if (a != null) {
                  setState(() {});
                  showDialog(
                    context: context,
                    builder: (context) =>
                        const AlertDialog(content: Text("Entry Saved")),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        const AlertDialog(content: Text("Entry not saved")),
                  );
                }
              }
            },
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (route) => false);
            },
            child: const Text(
              "Exit",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Column(children: [
        const Text("Title"),
        TextField(
          maxLines: 1,
          controller: titleController,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
        const Text("Your Thoughts"),
        TextField(
          controller: bodyController,
          maxLines: 50,
          minLines: 10,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
      ]),
    );
  }
}
