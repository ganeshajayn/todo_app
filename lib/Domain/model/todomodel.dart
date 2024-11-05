class Todomodel {
  String? id;
  String title;
  String description;
  String? createdat;
  String? isupdated;
  bool? iscompleted;
  Todomodel(
      {this.id,
      this.createdat,
      this.isupdated,
      required this.title,
      required this.description,
      required this.iscompleted});
  factory Todomodel.fromJson(Map<String, dynamic> json) => Todomodel(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        iscompleted: json["is_completed"],
        createdat: json["created_at"],
        isupdated: json['updated_at'],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "is_completed": iscompleted,
        "created_at": createdat,
        "updated_at": isupdated,
      };
}
