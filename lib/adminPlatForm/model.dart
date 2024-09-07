class Course {
  int? id;
  String? title;
  String? price;
  String? description;
  String? courseImage;
  int? duration;
  String? startingAt;
  String? endingAt;
  String? averageRating;
  int? isActive;
  int? teacherId;
  String? createdAt;
  String? updatedAt;

  Course(
      {this.id,
        this.title,
        this.price,
        this.description,
        this.courseImage,
        this.duration,
        this.startingAt,
        this.endingAt,
        this.averageRating,
        this.isActive,
        this.teacherId,
        this.createdAt,
        this.updatedAt});

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    courseImage = json['course_image'];
    duration = json['duration'];
    startingAt = json['starting_at'];
    endingAt = json['ending_at'];
    averageRating = json['average_rating'];
    isActive = json['is_active'];
    teacherId = json['teacher_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['description'] = this.description;
    data['course_image'] = this.courseImage;
    data['duration'] = this.duration;
    data['starting_at'] = this.startingAt;
    data['ending_at'] = this.endingAt;
    data['average_rating'] = this.averageRating;
    data['is_active'] = this.isActive;
    data['teacher_id'] = this.teacherId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}