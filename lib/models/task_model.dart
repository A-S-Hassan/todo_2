class TaskModel {
  String id;
  String title;
  String subTitle;
  int date;
  bool isDone;

  TaskModel(
      {required this.date,
      this.id = "",
      required this.title,
      this.isDone = false,
      required this.subTitle});

  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
            date: json['date'],
            title: json['title'],
            subTitle: json['subTitle'],
            isDone: json['isDone'],
            id: json['id']);

  Map<String, dynamic> toJson() {
    return {
      "date": date,
      "title": title,
      "subTitle": subTitle,
      "isDone": isDone,
      "id": id
    };
  }
}
