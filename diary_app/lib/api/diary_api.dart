// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constant.dart';
import '../model.dart';

const endpoint = "$baseUrl/diaryapp";

create(String title, String body) async {
  var uri = Uri.parse("${endpoint}create/");
  Map data = {"body": body, "title": title};
  var res = await http.post(uri, body: data);
  // print(res.body);
  // var json = jsonDecode(res.body);
  // print(json);

  if (res.statusCode == 200 || res.statusCode == 201) {
    return true;
  } else {
    return false;
  }
}

Future<List<Diary>> getDiary() async {
  List<Diary> entries = [];
  var url = Uri.parse("$endpoint/getListOfEntries");

  var res = await http.get(url);
  print(res.body);
  // print(json);
  if (res.statusCode == 200) {

    var jsons = jsonDecode(res.body);
    
    for (var json in jsons) {
      entries.add(Diary.fromJson(json));
    }

  }
  
  return entries;
  
}

Future<Diary?> getEntry(int entryID) async {
  var url = Uri.parse("$endpoint$entryID/");

  var res = await http.get(url);
  // print(res.body);
  // print(json);
  if (res.statusCode == 200) {
    var json = jsonDecode(res.body);

    return Diary.fromJson(json);
  }
  return null;
}

Future<bool> updateEntry(Diary entry) async {
  var url = Uri.parse("$endpoint/${entry.id}/deleteUpdateEntry/");

  var res = await http.put(
    url,
    body: entry.toJson(),
  );
  // print(res.body);
  // print(json);
  if (res.statusCode == 200) {
    // var json = jsonDecode(res.body);

    return true;
  }
  return false;
}

Future<bool> deleteEntry(int id) async {
  var url = Uri.parse("$endpoint/$id/delete/");

  var res = await http.delete(
    url,
  );
  // print(res.body);
  // print(json);
  if (res.statusCode == 200 || res.statusCode == 204) {
    // var json = jsonDecode(res.body);

    return true;
  }
  return false;
}
