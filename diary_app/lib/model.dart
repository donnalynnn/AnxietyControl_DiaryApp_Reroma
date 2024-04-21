class Diary {
  int id;
  String title;
  String body;
  // String dateCreated;

  Diary(this.id, this.title, this.body);
  
  factory Diary.fromJson(Map json) {
    return Diary(
      json["id"],
      json["title"],
      json["body"],
      // json["dateCreated"],
    );
  }

  Map<String, String> toJson() {
    return {
      "id": "$id",
      "title": title,
      "body": body,
      // "dateCreated": dateCreated,
    };
  }
}
