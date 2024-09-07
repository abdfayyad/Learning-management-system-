abstract class LessonsStudentStatus {}
class LessonsInitialized extends LessonsStudentStatus{}
class LessonsSuccess extends LessonsStudentStatus{

  LessonModelStudent lessonModelStudent;

  LessonsSuccess(this.lessonModelStudent);
}
class LessonsError extends LessonsStudentStatus{}
class LessonsLoading extends LessonsStudentStatus{}

class LessonModelStudent {
  List<Lessons>? lessons;

  LessonModelStudent({this.lessons});

  LessonModelStudent.fromJson(List<dynamic> json) {
    if (json != null) {
      lessons = json.map((i) => Lessons.fromJson(i)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (lessons != null) {
      data['lessons'] = lessons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class Lessons {
  int? id;
  String? title;
  String? lessonImage;
  String? videoUrl;
  String? startDate;
  String? description;
  String? createdAt;

  Lessons(
      {this.id,
        this.title,
        this.lessonImage,
        this.videoUrl,
        this.startDate,
        this.description,
        this.createdAt});

  Lessons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    lessonImage = json['lesson_image'];
    videoUrl = json['video_url'];
    startDate = json['start_date'];
    description = json['description'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['lesson_image'] = this.lessonImage;
    data['video_url'] = this.videoUrl;
    data['start_date'] = this.startDate;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    return data;
  }
}