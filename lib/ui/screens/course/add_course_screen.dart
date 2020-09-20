import 'package:chips_choice/chips_choice.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:edwisely/data/blocs/coursesBloc/courses_bloc.dart';
import 'package:edwisely/data/model/course/getAllCourses/data.dart';
import 'package:edwisely/data/model/course/getAllCourses/departments.dart';
import 'package:edwisely/data/model/course/sectionEntity/SectionEntity.dart';
import 'package:edwisely/data/model/course/sectionEntity/data.dart'
    as sectionDta;
import 'package:edwisely/ui/widgets_util/big_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

class AddCourseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BigAppBar(
              actions: null,
              titleText: 'Add Courses',
              bottomTab: null,
              appBarSize: MediaQuery.of(context).size.height / 3.5,
              appBarTitle: Text('Edwisely'),
              flatButton: null)
          .build(context),
      body: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 5,
            color: Colors.grey,
          ),
          Expanded(
            child: Center(
              child: BlocListener(
                cubit: context.bloc<CoursesBloc>(),
                listener: (BuildContext context, state) {
                  if (state is CourseAdded) {
                    Navigator.pop(context);
                  }
                },
                child: BlocBuilder(
                  cubit: context.bloc<CoursesBloc>()..add(GetAllCourses()),
                  builder: (BuildContext context, state) {
                    if (state is AllCoursesFetched) {
                      return Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              child: Container(
                                width: MediaQuery.of(context).size.width / 5,
                                padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width / 100,
                                ),
                                child: DropdownSearch(
                                  showClearButton: true,
                                  label: 'Search Courses',
                                  showSearchBox: true,
                                  mode: Mode.MENU,
                                  items: state.getAllCoursesEntity.data,
                                  onChanged: (Data data) => _showDialog(
                                    context,
                                    data,
                                    data.departments,
                                    state.sectionEntity,
                                  ),
                                  showSelectedItem: false,
                                  dropdownBuilder: (context, Data data,
                                          String sd) =>
                                      data != null ? Text(data.name) : Text(''),
                                  filterFn: (Data data, String string) =>
                                      data.name.toLowerCase().contains(
                                            string,
                                          ),
                                  popupItemBuilder:
                                      (context, Data data, bool) => Container(
                                    padding: EdgeInsets.all(
                                      10,
                                    ),
                                    child: Text(
                                      data.name,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: GridView(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 35,
                                    crossAxisSpacing: 35,
                                    crossAxisCount: 3,
                                    childAspectRatio:
                                        MediaQuery.of(context).size.width /
                                            MediaQuery.of(context).size.height /
                                            1.9,
                                  ),
                                  children: List.generate(
                                    state.getAllCoursesEntity.data.length,
                                    (upperIndex) => Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          6,
                                        ),
                                      ),
                                      elevation: 6,
                                      child: GridTile(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.center,
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    5,
                                                child: state
                                                            .getAllCoursesEntity
                                                            .data[upperIndex]
                                                            .course_image ==
                                                        ''
                                                    ? Image.asset(
                                                        'placeholder_image.jpg',
                                                        fit: BoxFit.cover,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            4,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            4,
                                                      )
                                                    : Image.network(
                                                        state
                                                            .getAllCoursesEntity
                                                            .data[upperIndex]
                                                            .course_image,
                                                      ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                15,
                                              ),
                                              child: Text(
                                                state.getAllCoursesEntity
                                                    .data[upperIndex].name,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          50,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                15,
                                              ),
                                              child: Text(
                                                'Departments',
                                                style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          70,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 15),
                                              child: Wrap(
                                                children: List.generate(
                                                  state
                                                      .getAllCoursesEntity
                                                      .data[upperIndex]
                                                      .departments
                                                      .length,
                                                  (index) => Chip(
                                                    label: Text(
                                                      state
                                                          .getAllCoursesEntity
                                                          .data[upperIndex]
                                                          .departments[index]
                                                          .name,
                                                    ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(5)
                                                    ),
                                                  ),
                                                ),
                                                runSpacing: 10,
                                                spacing: 10,
                                              ),
                                            )
                                          ],
                                        ),
                                        footer: Row(
                                          children: [
                                            Container(
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                  15,
                                                ),
                                                child: FlatButton.icon(
                                                  hoverColor: Color(0xFF1D2B64)
                                                      .withOpacity(.2),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    side: BorderSide(
                                                      color: Color(0xFF1D2B64),
                                                    ),
                                                  ),
                                                  onPressed: () => _showDialog(
                                                    context,
                                                    state.getAllCoursesEntity
                                                        .data[upperIndex],
                                                    state
                                                        .getAllCoursesEntity
                                                        .data[upperIndex]
                                                        .departments,
                                                    state.sectionEntity,
                                                  ),
                                                  icon: Icon(Icons.add),
                                                  label: Text('Add'),
                                                ),
                                              ),
                                              width: 150,
                                            ),
                                          ],
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _showDialog(
    BuildContext outerContext,
    Data data,
    List<Departments> departments,
    SectionEntity sectionEntity,
  ) {
    int branch;
    List<int> sections = [];
    showDialog(
      context: outerContext,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return AlertDialog(
              title: Text(
                'Finalize Adding ${data.name} to Your Courses',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.height / 50,
                ),
              ),
              content: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Which Department Do You Teach ? ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height / 50,
                      ),
                    ),
                    ChipsChoice.single(
                      value: branch,
                      options: ChipsChoiceOption.listFrom(
                        source: departments,
                        value: (i, Departments dep) => dep.subject_semester_id,
                        label: (i, Departments dep) => dep.name,
                      ),
                      onChanged: (val) => setState(() {
                        branch = val;
                      }),
                    ),
                    Text(
                      'Pick Your Class',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height / 50,
                      ),
                    ),
                    ChipsChoice<int>.multiple(
                      value: sections,
                      isWrapped: true,
                      options: ChipsChoiceOption.listFrom(
                        source: sectionEntity.data,
                        value: (i, sectionDta.Data v) => v.id,
                        label: (i, sectionDta.Data v) => v.name,
                      ),
                      onChanged: (val) => setState(
                        () => sections = val,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton.icon(
                          onPressed: () {
                            print('department : $branch');
                            print('sections : $sections');
                            print('subject : ${data.id}');
                            if (branch == null || sections.isEmpty) {
                              Toast.show(
                                  'Please select atleast one section and one department',
                                  context,
                                  duration: 4);
                            }
                            outerContext.bloc<CoursesBloc>().add(
                                  AddCourseToFaculty(
                                    data.id,
                                    branch,
                                    sections,
                                  ),
                                );
                          },
                          icon: Icon(
                            Icons.save,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Save',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          color: Color(0xFF1D2B64),
                        ),
                        FlatButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancel'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                            side: BorderSide(
                              color: Color(0xFF1D2B64),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
