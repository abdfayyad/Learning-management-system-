
class SearchCourseModel {
  List<CourseStudent>? searchCourse;

  SearchCourseModel({this.searchCourse});

  SearchCourseModel.fromJson(Map<String, dynamic> json) {
    if (json['courses'] != null) {
      searchCourse = <CourseStudent>[];
      json['courses'].forEach((v) {
        searchCourse!.add(new CourseStudent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.searchCourse != null) {
      data['courses'] =
          this.searchCourse!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseStudent {
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

  CourseStudent(
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

  CourseStudent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseTitle = json['title'];
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
