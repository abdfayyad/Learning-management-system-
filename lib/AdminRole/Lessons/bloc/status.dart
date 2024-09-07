abstract class LessonsStatus {}
class LessonsInitialized extends LessonsStatus{}
class LessonsSuccess extends LessonsStatus{

  LessonModelTeacher lessonModelTeacher;

  LessonsSuccess(this.lessonModelTeacher);
}
class LessonsError extends LessonsStatus{}
class LessonsLoading extends LessonsStatus{}

class LessonModelTeacher {
  List<Lessons>? lessons;

  LessonModelTeacher({this.lessons});

  LessonModelTeacher.fromJson(Map<String, dynamic> json) {
    if (json['lessons'] != null) {
      lessons = <Lessons>[];
      json['lessons'].forEach((v) {
        lessons!.add(new Lessons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lessons != null) {
      data['lessons'] = this.lessons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lessons {
  int? id;
  String? lessonTitle;
  String? lessonVideo;
  String? startDate;
  String? courseTitle;
  String? description;

  Lessons(
      {this.id,
        this.lessonTitle,
        this.lessonVideo,
        this.startDate,
        this.courseTitle,
        this.description});

  Lessons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lessonTitle = json['lesson_title'];
    lessonVideo = json['lesson_video'];
    startDate = json['start_date'];
    courseTitle = json['course_title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lesson_title'] = this.lessonTitle;
    data['lesson_video'] = this.lessonVideo;
    data['start_date'] = this.startDate;
    data['course_title'] = this.courseTitle;
    data['description'] = this.description;
    return data;
  }
}