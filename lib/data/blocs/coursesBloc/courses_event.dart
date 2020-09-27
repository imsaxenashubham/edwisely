part of 'courses_bloc.dart';

@immutable
abstract class CoursesEvent {}

class GetCoursesByFaculty extends CoursesEvent {}

class GetCoursesList extends CoursesEvent {}

class GetSections extends CoursesEvent {}

class GetSectionsAndGetCoursesList extends CoursesEvent {}

class GetCourse extends CoursesEvent {
  final int subjectSemesterId;

  GetCourse(this.subjectSemesterId);
}

class GetCourseSyllabus extends CoursesEvent {
  final int subjectSemesterId;

  GetCourseSyllabus(this.subjectSemesterId);
}

class GetAllCourses extends CoursesEvent {}

class SortCourses extends CoursesEvent {
  final String pattern;

  final CoursesEntity coursesEntity;
  final CoursesEntity originalCourseEntity;

  SortCourses(this.pattern, this.coursesEntity, this.originalCourseEntity);
}
