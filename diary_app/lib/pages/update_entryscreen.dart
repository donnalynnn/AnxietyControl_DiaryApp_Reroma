// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'package:diary_app/api/diary_api.dart';
import 'package:flutter/cupertino.dart';
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
        // backgroundColor: const Color(0xFF8fa247),
        title: const Text("Edit Entry"),
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
              style: TextStyle(color:Color(0xFF8fa247)),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (route) => false);
            },
            child: const Text(
              "Exit",
              style: TextStyle(color:Color(0xFF8fa247)),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
      body: Container(
        color: const Color.fromARGB(97, 168, 187, 100),
        child: 
          Padding(
            padding: const EdgeInsets.all(20),
            child: 
              Column(children: [
                const SizedBox(height: 20,),
                const Row(
                  children: [
                    Text("Entry Title  ", 
                      style: TextStyle(color:  Color(0xFF8fa247)),),
                    Icon(Icons.edit,color:  Color(0xFF8fa247),size: 18,),
                    SizedBox(width: 45,)
                  ],
                ),

                TextField(
                  maxLines: 1,
                  controller: titleController,
                  style: const TextStyle(
                    fontSize: 25,
              
                  ),
                  decoration: 
                  const InputDecoration(
                    // border: UnderlineInputBorder(),
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    // icon: Icon(Icons.edit, color: Colors.white,size: 10,)
              
                    ),
                ),

                const SizedBox(height: 25,),
                const Row(
                  children: [
                    Text("Your Thoughts  ", 
                      style: TextStyle(color: Color(0xFF8fa247)),),
                    Icon(Icons.edit,color: Color(0xFF8fa247),size: 18,),
                    SizedBox(width: 45,)
                  ],
                ),
                const SizedBox(height: 10,),
                TextField(
                  controller: bodyController,
                  maxLines: 50,
                  minLines: 10,
                  style: const TextStyle(color: Colors.black87),
                  decoration: 
                  const InputDecoration(
                    border: OutlineInputBorder(),
                    
                    ),
                ),
              ]),
            
          ),
        
      ),
    );
  }
}
