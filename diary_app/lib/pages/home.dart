// ignore_for_file: use_build_context_synchronously
import 'package:diary_app/api/diary_api.dart';
import 'package:diary_app/model.dart';
import 'package:diary_app/pages/create_entryscreen.dart';
import 'package:diary_app/pages/update_entryscreen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8fa247),
      appBar: AppBar(
        title: Row(
            children: [
              Image.asset(
                'assets/images/Anxiety Control.png',
                height: 125,
                width: 200,
                )
              ],
        ),
        backgroundColor: const Color(0xFF8fa247),
      ),
      body: FutureBuilder<List<Diary>>(
          future: getDiary(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            List<Diary> entry = snapshot.data!;

            return Column(
              children: [
                // SizedBox(
                //     height: 50,
                //     child: Center(
                //         child: Image.asset('assets/images/diary_app_logo.png',
                //             fit: BoxFit.cover))),
                GridView.count(crossAxisCount: 2, shrinkWrap: true, children: [
                  ...entry.map((currentEntry) {
                    return InkWell(
                      onLongPress: () async {
                        String a = await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: const Text(
                                      "Do you want to delete entry?"),
                                  actions: [
                                    OutlinedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop("confirm");
                                      },
                                      child: const Text("Confirm"),
                                    ),
                                    OutlinedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop("cancel");
                                      },
                                      child: const Text("Cancel"),
                                    ),
                                  ],
                                ));
                        if (a == "confirm") {
                          var b = await deleteEntry(currentEntry.id);
                          if (b) {
                            await showDialog(
                                context: context,
                                builder: (context) => const AlertDialog(
                                      content:
                                          Text("Note Successfully Deleted"),
                                    ));
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()),
                                (route) => false);
                          } else {
                            await showDialog(
                                context: context,
                                builder: (context) => const AlertDialog(
                                      content: Text("Something went wrong"),
                                    ));
                          }
                        }
                      },
                      onTap: () async {
                        // Diary? entry = await getEntry(currentEntry.id);

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                UpdateEntryScreen(entry: currentEntry),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20) ,
                          child:
                            Column(children: [
                              const SizedBox(
                                height: 5,
                              ),

                              Text(currentEntry.title, 
                              style: const TextStyle(
                                fontSize: 18,
                                color:  Color(0xFF8fa247),

                                ),),
                              const SizedBox(
                                height: 5,
                              ),
                              // Text(currentEntry.body),
                              Text(
                                currentEntry.body.length > 50
                                    ? "${currentEntry.body.substring(0, 50)}..."
                                    : currentEntry.body,
                              )
                            ]),
                        ),
                      ),
                    );
                  }).toList(),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const CreateEntryScreen()));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.add),
                    ),
                  )
                ]),
              ],
            );
          }),
    );
  }
}
