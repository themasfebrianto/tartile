import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tartile/features/module/application/blocs/course/course_event.dart';
import 'package:tartile/features/module/application/blocs/course/course_state.dart';
import 'package:tartile/features/module/data/dtos/course/course_filter_dto.dart';
import 'package:tartile/features/module/domain/repositories/course_repository.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final CourseRepository repository;

  CourseBloc({required this.repository}) : super(CourseInitial()) {
    on<LoadCourses>(_onLoadCourses);
    on<RefreshCourses>(_onRefreshCourses);
  }

  Future<void> _onLoadCourses(
    LoadCourses event,
    Emitter<CourseState> emit,
  ) async {
    emit(CourseLoading());
    try {
      final courses = await repository.getAll(
        event.filter ?? CourseFilterDto(),
      );
      emit(CourseLoaded(courses));
    } catch (e) {
      emit(CourseError(e.toString()));
    }
  }

  Future<void> _onRefreshCourses(
    RefreshCourses event,
    Emitter<CourseState> emit,
  ) async {
    try {
      final courses = await repository.getAll(
        event.filter ?? CourseFilterDto(),
      );
      emit(CourseLoaded(courses));
    } catch (e) {
      emit(CourseError(e.toString()));
    }
  }
}
