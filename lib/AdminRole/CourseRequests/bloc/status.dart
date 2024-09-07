abstract class CourseRequestStatus {}
class CourseRequestInitialized extends CourseRequestStatus{}
class CourseRequestSuccess extends CourseRequestStatus{
  CourseRequestsModel courseRequestsModel;

  CourseRequestSuccess(this.courseRequestsModel);
}
class CourseRequestError extends CourseRequestStatus{}
class CourseRequestLoading extends CourseRequestStatus{}

class CourseRequestsModel{
  static CourseRequestsModel? fromJson(parsedJson) {}
}