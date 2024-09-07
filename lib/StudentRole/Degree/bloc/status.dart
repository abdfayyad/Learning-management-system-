abstract class DegreeStatus {}
class DegreeInitialized extends DegreeStatus{}
class DegreeSuccess extends DegreeStatus{
  DegreeModel degreeModel;

  DegreeSuccess(this.degreeModel);
}
class DegreeError extends DegreeStatus{}
class DegreeLoading extends DegreeStatus{}

class DegreeModel {
  List<Marks>? marks;

  DegreeModel({this.marks});

  DegreeModel.fromJson(Map<String, dynamic> json) {
    if (json['marks'] != null) {
      marks = <Marks>[];
      json['marks'].forEach((v) {
        marks!.add(new Marks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.marks != null) {
      data['marks'] = this.marks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Marks {
  int? id;
  String? examTitle;
  String? courseTitle;
  String? courseImage;
  int? result;
  String? date;

  Marks(
      {this.id,
        this.examTitle,
        this.courseTitle,
        this.courseImage,
        this.result,
        this.date});

  Marks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    examTitle = json['exam_title'];
    courseTitle = json['course_title'];
    courseImage = json['course_image'];
    result = json['result'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['exam_title'] = this.examTitle;
    data['course_title'] = this.courseTitle;
    data['course_image'] = this.courseImage;
    data['result'] = this.result;
    data['date'] = this.date;
    return data;
  }
}