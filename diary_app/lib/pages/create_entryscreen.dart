// ignore_for_file: use_build_context_synchronously

import 'package:diary_app/api/diary_api.dart';
import 'package:flutter/material.dart';
import 'home.dart';


class CreateEntryScreen extends StatefulWidget {
  const CreateEntryScreen({super.key});

  @override
  State<CreateEntryScreen> createState() => _CreateEntryScreenState();
}

class _CreateEntryScreenState extends State<CreateEntryScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
  }
// flutter run
  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Entry"),
        actions: [
          OutlinedButton(
              onPressed: () async {
                if (titleController.text.isNotEmpty &&
                    bodyController.text.isNotEmpty) {
                  var a = await create(
                    titleController.text,
                    bodyController.text,
                  );
                  if (a) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const HomePage()),
                        (route) => false);
                  }
                }
              },
              child: const Text(
                "Create",
                style: TextStyle(color: Colors.white),
              ))
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
