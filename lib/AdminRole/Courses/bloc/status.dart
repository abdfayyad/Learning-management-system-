abstract class CoursesStatus {}
class CoursesInitialized extends CoursesStatus{}
class CoursesSuccess extends CoursesStatus{
  CourseModelTeacher courseModelTeacher;

  CoursesSuccess(this.courseModelTeacher);
}
class CoursesError extends CoursesStatus{}
class CoursesLoading extends CoursesStatus{}

class CourseModelTeacher {
  List<CourseTeacher>? courseTeacher;

  CourseModelTeacher({this.courseTeacher});

  CourseModelTeacher.fromJson(Map<String, dynamic> json) {
    if (json['CourseTeacher'] != null) {
      courseTeacher = <CourseTeacher>[];
      json['CourseTeacher'].forEach((v) {
        courseTeacher!.add(new CourseTeacher.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.courseTeacher != null) {
      data['CourseTeacher'] =
          this.courseTeacher!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseTeacher {
  int? id;
  String? courseTitle;
  String? description;
  String? price;
  String? courseImage;
  String? startingAt;
  String? endingAt;
  int? duration;
  int? isActive;
  String? averageRating;

  CourseTeacher(
      {this.id,
        this.courseTitle,
        this.description,
        this.price,
        this.courseImage,
        this.startingAt,
        this.endingAt,
        this.duration,
        this.isActive,
        this.averageRating});

  CourseTeacher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseTitle = json['course_title'];
    description = json['description'];
    price = json['price'];
    courseImage = json['course_image'];
    startingAt = json['starting_at'];
    endingAt = json['ending_at'];
    duration = json['duration'];
    isActive = json['is_active'];
    averageRating = json['average_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_title'] = this.courseTitle;
    data['description'] = this.description;
    data['price'] = this.price;
    data['course_image'] = this.courseImage;
    data['starting_at'] = this.startingAt;
    data['ending_at'] = this.endingAt;
    data['duration'] = this.duration;
    data['is_active'] = this.isActive;
    data['average_rating'] = this.averageRating;
    return data;
  }
}