import 'package:edwisely/ui/screens/course/courseDetailScreen/course_detail_about_tab.dart';
import 'package:edwisely/ui/screens/course/courseDetailScreen/course_detail_course_content_tab.dart';
import 'package:edwisely/ui/screens/course/courseDetailScreen/course_detail_question_bank_tab.dart';
import 'package:edwisely/ui/screens/course/courseDetailScreen/course_detail_syllabus_tab.dart';
import 'package:edwisely/ui/widgets_util/big_app_bar.dart';
import 'package:edwisely/ui/widgets_util/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/provider/selected_page.dart';

import '../../../../util/theme.dart';
import '../../../../util/theme.dart';

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

  bool _isCollapsed = true;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('semseter subjectid for fm2 ${widget.semesterSubjectId}');
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          NavigationDrawer(
            isCollapsed: _isCollapsed,
            key: context.watch<SelectedPageProvider>().navigatorKey,
          ),
          Expanded(
            child: Column(
              children: [
                BigAppBar(
                        actions: null,
                        titleText: widget._courseName,
                        appBarSize: MediaQuery.of(context).size.height / 3,
                        bottomTab: null,
                        appBarTitle: Text(
                          'Edwisely',
                          style: TextStyle(color: Colors.black),
                        ),
                        flatButton: null)
                    .build(context),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TabBar(
                          labelPadding: EdgeInsets.symmetric(horizontal: 36.0),
                          indicatorColor: EdwiselyTheme.PRIMARY_COLOR,
                          labelColor: Colors.white,
                          indicator: BoxDecoration(
                            color: EdwiselyTheme.PRIMARY_COLOR,
                          ),
                          indicatorPadding: const EdgeInsets.only(top: 8.0),
                          unselectedLabelColor: EdwiselyTheme.PRIMARY_COLOR,
                          unselectedLabelStyle:
                              Theme.of(context).textTheme.headline6,
                          labelStyle: Theme.of(context).textTheme.headline5,
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
                      ),
                      Expanded(
                        child: TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          controller: _tabController,
                          children: [
                            CourseDetailAboutTab(
                              widget.semesterSubjectId,
                            ),
                            CourseDetailSyllabusTab(
                              widget.semesterSubjectId,
                            ),
                            CourseDetailCourseContentTab(
                              widget.semesterSubjectId,
                            ),
                            CourseDetailQuestionBankTab(
                              widget.semesterSubjectId,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
