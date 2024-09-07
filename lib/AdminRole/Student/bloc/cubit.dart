import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first/AdminRole/Student/bloc/status.dart';
import 'package:first/AdminRole/Student/bloc/cubit.dart';
import 'ModelAndHttpFunction.dart';

class StudentCubit extends Cubit<StudentStatus> {
  StudentCubit() : super(StudentInitialized());

  Future<void> loadStudents() async {
    try {
      emit(StudentLoading());
      final students = await fetchStudents();
      if (!isClosed) {  // Check if Cubit is still open
        emit(StudentLoaded(students: students));
      }
    } catch (e) {
      if (!isClosed) {  // Check if Cubit is still open
        emit(StudentError(message: 'Failed to load students'));
      }
    }
  }
}
