import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api.dart';
import '../../model/course/courseDeckEntity/CourseDeckEntity.dart';
import '../../model/course/courseEntity/CourseEntity.dart';
import '../../model/course/coursesEntity/CoursesEntity.dart';
import '../../model/course/getAllCourses/GetAllCoursesEntity.dart';
import '../../model/course/sectionEntity/SectionEntity.dart';
import '../../model/course/syllabusEntity/SyllabusEntity.dart';

part 'courses_event.dart';
part 'courses_state.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  CoursesBloc() : super(CoursesInitial());

  @override
  Stream<CoursesState> mapEventToState(
    CoursesEvent event,
  ) async* {
    if (event is GetCoursesByFaculty) {
      final response = await EdwiselyApi()
          .dio()
          .then((value) => value.get('getFacultyCourses'));
      print(response.data);
      if (response.statusCode == 200) {
        if (response.data['status'] != 200) {
          SharedPreferences.getInstance()
              .then((value) => value.setString('login_key', null));
          yield LoginFailed();
        } else {
          yield CoursesFetched(CoursesEntity.fromJsonMap(response.data));
        }
      } else {
        CoursesFetchFailed();
      }
    }
    if (event is GetCoursesList) {
      final subjectResponse = await EdwiselyApi()
          .dio()
          .then((value) => value.get('getFacultyCourses'));
      if (subjectResponse.statusCode == 200) {
        List<DropdownMenuItem> subjects = [];
        subjects.add(
          DropdownMenuItem(
            child: Text('All'),
            value: 1234567890,
          ),
        );
        CoursesEntity.fromJsonMap(subjectResponse.data).data.forEach(
          (element) {
            subjects.add(
              DropdownMenuItem(
                child: Text(element.name),
                value: element.id,
              ),
            );
          },
        );
        yield CoursesListFetched(subjects);
      } else {
        yield CoursesFetchFailed();
      }
    }
    if (event is GetSectionsAndGetCoursesList) {
      final response = await EdwiselyApi().dio().then((value) => value.get(
          //todo change to event
          'getCourseDepartmentSections?university_degree_department_id=71'));
      final subjectResponse = await EdwiselyApi()
          .dio()
          .then((value) => value.get('getFacultyCourses'));
      if (response.statusCode == 200 && subjectResponse.statusCode == 200) {
        List<DropdownMenuItem> subjects = [];
        subjects.add(
          DropdownMenuItem(
            child: Text('All'),
            value: 1234567890,
          ),
        );
        CoursesEntity.fromJsonMap(subjectResponse.data).data.forEach(
          (element) {
            subjects.add(
              DropdownMenuItem(
                child: Text(element.name),
                value: element.id,
              ),
            );
          },
        );
        yield SectionsAndGetCoursesListFetched(
          subjects,
          SectionEntity.fromJsonMap(response.data),
        );
      } else {
        yield CoursesFetchFailed();
      }
    }
    if (event is GetSections) {
      final response = await EdwiselyApi().dio().then((value) => value.get(
          //todo change to event
          'getCourseDepartmentSections?university_degree_department_id=71'));
      if (response.statusCode == 200) {
        yield SectionsFetched(
          SectionEntity.fromJsonMap(response.data),
        );
      } else {
        yield CoursesFetchFailed();
      }
    }
    if (event is GetCourse) {
      final response = await EdwiselyApi().dio().then((value) => value.get(
          'getCourseDetails?subject_semester_id=${event.subjectSemesterId}'));
      if (response.statusCode == 200) {
        yield CourseAboutDetailsFetched(
          CourseEntity.fromJsonMap(response.data),
        );
      } else {
        yield CoursesFetchFailed();
      }
    }
    if (event is GetCourseSyllabus) {
      final response = await EdwiselyApi().dio().then((value) => value.get(
          'getCourseSyllabus?subject_semester_id=${event.subjectSemesterId}'));
      if (response.statusCode == 200) {
        yield CourseSyllabusFetched(
          SyllabusEntity.fromJsonMap(response.data),
        );
      } else {
        yield CoursesFetchFailed();
      }
    }
    if (event is GetAllCourses) {
      final courses =
          await EdwiselyApi().dio().then((value) => value.get('getCourses'));
      final courseDep = await EdwiselyApi().dio().then((value) => value.get(
          'getCourseDepartmentSections?university_degree_department_id=71'));
      if (courses.statusCode == 200 && courseDep.statusCode == 200) {
        yield AllCoursesFetched(GetAllCoursesEntity.fromJsonMap(courses.data),
            SectionEntity.fromJsonMap(courseDep.data));
      } else {
        yield CoursesFetchFailed();
      }
    }
  }
}
