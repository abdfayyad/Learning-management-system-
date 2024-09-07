import 'package:first/AdminRole/Student/bloc/ModelAndHttpFunction.dart';

abstract class StudentStatus {}

class StudentInitialized extends StudentStatus {}

class StudentLoading extends StudentStatus {}

class StudentLoaded extends StudentStatus {
  final List<Student> students;
  StudentLoaded({required this.students});
}

class StudentError extends StudentStatus {
  final String message;
  StudentError({required this.message});
}
