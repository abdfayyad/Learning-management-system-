abstract class ExamsStudentStatus {}

class ExamsStudentInitial extends ExamsStudentStatus {}

class ExamsStudentLoaded extends ExamsStudentStatus {
ExamModel examModel;

ExamsStudentLoaded(this.examModel);
}

class ExamsStudentError extends ExamsStudentStatus {
  final String message;
  ExamsStudentError(this.message);
}

class ExamModel {
  List<Exams>? exams;

  ExamModel({this.exams});

  ExamModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      exams = <Exams>[];
      json['data'].forEach((v) {
        exams!.add(new Exams.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.exams != null) {
      data['exams'] = this.exams!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Exams {
  late int id;
  String? title;
  String? courseTitle;
  String? createdAt;

  Exams({ required this.id, this.title, this.courseTitle, this.createdAt});

  Exams.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['exam_title'];
courseTitle=json['course_title'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['course_title'] = this.courseTitle;
    data['created_at'] = this.createdAt;
    return data;
  }
}