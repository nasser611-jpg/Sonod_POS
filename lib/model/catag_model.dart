class Class {
  int? classId;
  String className;

  Class({this.classId, required this.className});

  Map<String, dynamic> toMap() {
    return {
      'class_id': classId,
      'class_name': className,
    };
  }
}
