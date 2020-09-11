import 'package:edwisely/data/blocs/assessmentLandingScreen/coursesBloc/courses_bloc.dart';
import 'package:edwisely/ui/screens/course/courseDetailScreen/course_detail_about_tab.dart';
import 'package:edwisely/ui/screens/course/courseDetailScreen/course_detail_course_content_tab.dart';
import 'package:edwisely/ui/screens/course/courseDetailScreen/course_detail_question_bank_tab.dart';
import 'package:edwisely/ui/screens/course/courseDetailScreen/course_detail_syllabus_tab.dart';
import 'package:edwisely/ui/widgets_util/big_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseDetailScreen extends StatefulWidget {
  final String _courseName;
  final int semesterSubjectId;

  CourseDetailScreen(this._courseName, this.semesterSubjectId);

  @override
  _CourseDetailScreenState createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BigAppBar(
              actions: null,
              titleText: widget._courseName,
              bottomTab: TabBar(
                labelPadding: EdgeInsets.symmetric(horizontal: 30),
                indicatorColor: Colors.white,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                isScrollable: true,
                controller: _tabController,
                tabs: [
                  Tab(
                    text: 'About',
                  ),
                  Tab(
                    text: 'Syllabus',
                  ),
                  Tab(
                    text: 'Course Content',
                  ),
                  Tab(
                    text: 'Question Bank',
                  ),
                ],
              ),
              appBarSize: MediaQuery.of(context).size.height / 3,
              appBarTitle: Text(
                'Edwisely',
                style: TextStyle(color: Colors.black),
              ),
              flatButton: null)
          .build(context),
      body: TabBarView(
        controller: _tabController,
        children: [
          BlocProvider(
            create: (BuildContext context) => CoursesBloc()
              ..add(
                GetCourse(
                  widget.semesterSubjectId,
                ),
              ),
            child: CourseDetailAboutTab(),
          ),
          BlocProvider(
            create: (BuildContext context) => CoursesBloc()
              ..add(
                GetCourseSyllabus(
                  widget.semesterSubjectId,
                ),
              ),
            child: CourseDetailSyllabusTab(),
          ),
          BlocProvider(
            create: (BuildContext context) => CoursesBloc()
              ..add(
                GetCourseContentData(
                  widget.semesterSubjectId,
                ),
              ),
            child: CourseDetailCourseContentTab(),
          ),
          BlocProvider(
            create: (BuildContext context) => CoursesBloc(),
            child: CourseDetailQuestionBankTab(),
          ),
        ],
      ),
    );
  }
}