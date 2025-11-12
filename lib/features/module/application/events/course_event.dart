import 'package:equatable/equatable.dart';
import 'package:tartile/features/module/data/dtos/course/course_filter_dto.dart';

abstract class CourseEvent extends Equatable {
  const CourseEvent();

  @override
  List<Object?> get props => [];
}

class LoadCourses extends CourseEvent {
  final CourseFilterDto? filter;

  const LoadCourses({this.filter});

  @override
  List<Object?> get props => [filter];
}

class RefreshCourses extends CourseEvent {
  final CourseFilterDto? filter;

  const RefreshCourses({this.filter});

  @override
  List<Object?> get props => [filter];
}
