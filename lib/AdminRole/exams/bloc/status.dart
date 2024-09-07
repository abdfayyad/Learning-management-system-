abstract class ExamsStatus {}
class ExamsInitialized extends ExamsStatus{}
class ExamsSuccess extends ExamsStatus{

  ExamModel examModel;

  ExamsSuccess(this.examModel);
}
class ExamsError extends ExamsStatus{}
class ExamsLoading extends ExamsStatus{}


class ExamModel {
  List<Exams>? exams;

  ExamModel({this.exams});

  ExamModel.fromJson(Map<String, dynamic> json) {
    if (json['exams'] != null) {
      exams = <Exams>[];
      json['exams'].forEach((v) {
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
  int? id;
  String? title;
  String? courseTitle;
  String? createdAt;

  Exams({this.id, this.title, this.courseTitle, this.createdAt});

  Exams.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    courseTitle = json['course_title'];
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