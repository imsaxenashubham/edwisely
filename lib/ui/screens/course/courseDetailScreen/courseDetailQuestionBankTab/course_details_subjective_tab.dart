import 'package:edwisely/data/blocs/questionBank/questionBankSubjective/question_bank_subjective_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionBankSubjectiveTab extends StatefulWidget {
  final int subjectId;

  QuestionBankSubjectiveTab(this.subjectId);

  @override
  _QuestionBankSubjectiveTabState createState() =>
      _QuestionBankSubjectiveTabState();
}

class _QuestionBankSubjectiveTabState extends State<QuestionBankSubjectiveTab> {
  int levelDropDownValue = -1;
  int topicsDropDown = 1234567890;
  int bookmarkRadio = 0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder(
        cubit: context.bloc<QuestionBankSubjectiveBloc>(),
        builder: (BuildContext context, state) {
          if (state is UnitSubjectiveQuestionsFetched) {
            return Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: ListView(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                DropdownButton(
                                    items: [
                                      DropdownMenuItem(
                                        child: Text('No Level'),
                                        value: -1,
                                      ),
                                      DropdownMenuItem(
                                        child: Text('Level 1'),
                                        value: 1,
                                      ),
                                      DropdownMenuItem(
                                        child: Text('Level 2'),
                                        value: 2,
                                      ),
                                      DropdownMenuItem(
                                        child: Text('Level 3'),
                                        value: 3,
                                      ),
                                      DropdownMenuItem(
                                        child: Text('Level 4'),
                                        value: 4,
                                      ),
                                      DropdownMenuItem(
                                        child: Text('Level 5'),
                                        value: 5,
                                      ),
                                    ],
                                    value: levelDropDownValue,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          levelDropDownValue = value;
                                        },
                                      );
                                      value == -1
                                          ? context
                                              .bloc<
                                                  QuestionBankSubjectiveBloc>()
                                              .add(
                                                GetUnitSubjectiveQuestions(
                                                  widget.subjectId,
                                                  state.unitId,
                                                ),
                                              )
                                          : context
                                              .bloc<
                                                  QuestionBankSubjectiveBloc>()
                                              .add(
                                                GetUnitSubjectiveQuestionsByLevel(
                                                  value,
                                                  state.unitId,
                                                ),
                                              );
                                    }),
                                DropdownButton(
                                  items: state.dropDownList,
                                  value: topicsDropDown,
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        topicsDropDown = value;
                                      },
                                    );
                                    value == 1234567890
                                        ? context
                                            .bloc<QuestionBankSubjectiveBloc>()
                                            .add(
                                              GetUnitSubjectiveQuestions(
                                                widget.subjectId,
                                                state.unitId,
                                              ),
                                            )
                                        : context
                                            .bloc<QuestionBankSubjectiveBloc>()
                                            .add(
                                              GetUnitSubjectiveQuestionsByTopic(
                                                value,
                                                state.unitId,
                                              ),
                                            );
                                  },
                                ),
                                Container(
                                  child: RadioListTile(
                                    title: Text('All Questions'),
                                    value: 0,
                                    groupValue: bookmarkRadio,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          bookmarkRadio = value;
                                        },
                                      );
                                      context
                                          .bloc<QuestionBankSubjectiveBloc>()
                                          .add(
                                            GetUnitSubjectiveQuestions(
                                              widget.subjectId,
                                              state.unitId,
                                            ),
                                          );
                                    },
                                  ),
                                  width: 170,
                                  height: 50,
                                ),
                                Container(
                                  child: RadioListTile(
                                    title: Text('Bookmarked'),
                                    value: 1,
                                    groupValue: bookmarkRadio,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          bookmarkRadio = value;
                                        },
                                      );
                                      context
                                          .bloc<QuestionBankSubjectiveBloc>()
                                          .add(
                                            GetSubjectiveQuestionsByBookmark(
                                              state.unitId,
                                            ),
                                          );
                                    },
                                  ),
                                  width: 200,
                                  height: 50,
                                ),
                                Container(
                                  child: RadioListTile(
                                    title: Text('Your Questions'),
                                    value: 2,
                                    groupValue: bookmarkRadio,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          bookmarkRadio = value;
                                        },
                                      );
                                      context
                                          .bloc<QuestionBankSubjectiveBloc>()
                                          .add(
                                            GetYourSubjectiveQuestions(
                                              state.unitId,
                                            ),
                                          );
                                    },
                                  ),
                                  width: 200,
                                  height: 50,
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                            ),
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * (3.5 / 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Subjective Questions',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              50,
                                    ),
                                  ),
                                  FlatButton(
                                    hoverColor:
                                        Color(0xFF1D2B64).withOpacity(.2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      side: BorderSide(
                                        color: Color(0xFF1D2B64),
                                      ),
                                    ),
                                    onPressed: () => null,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: Color(0xFF1D2B64),
                                        ),
                                        Text(
                                          'Add Your Questions',
                                          style: TextStyle(
                                            color: Color(0xFF1D2B64),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            BlocBuilder(
                              cubit: context.bloc<QuestionBankSubjectiveBloc>(),
                              builder: (BuildContext context, state) {
                                if (state is UnitSubjectiveQuestionsFetched) {
                                  return ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: state
                                        .questionBankSubjectiveEntity
                                        .data
                                        .length,
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            ListTile(
                                      title: Row(
                                        children: [
                                          Text('Q. ${index + 1}'),
                                          Image.network(
                                            state.questionBankSubjectiveEntity
                                                .data[index].question_img[0],
                                            width: 250,
                                            height: 250,
                                          ),
                                        ],
                                      ),
                                      subtitle: Text(
                                        'Level ${state.questionBankSubjectiveEntity.data[index].blooms_level}',
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(Icons.bookmark),
                                        onPressed: null,
                                      ),
                                    ),
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return Divider(
                                        thickness: 2,
                                        color: Colors.grey,
                                      );
                                    },
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                            FlatButton(
                              hoverColor: Color(0xFF1D2B64).withOpacity(.2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                                side: BorderSide(
                                  color: Color(0xFF1D2B64),
                                ),
                              ),
                              onPressed: () => null,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: Color(0xFF1D2B64),
                                  ),
                                  Text(
                                    'View More',
                                    style: TextStyle(
                                      color: Color(0xFF1D2B64),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 3,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
