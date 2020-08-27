import 'package:edwisely/models/assessment.dart';
import 'package:edwisely/models/question.dart';
import 'package:edwisely/swatches/gradients.dart';
import 'package:edwisely/widgets/assessment/assessmentPanel.dart';
import 'package:edwisely/widgets/borderButton.dart';
import 'package:edwisely/widgets/assessment/previewTile.dart';
import 'package:edwisely/widgets/gradientAppBar.dart';
import 'package:flutter/material.dart';

class AssessmentPage extends StatefulWidget {
  Assessment assessment;
  AssessmentPage({@required this.assessment});
  @override
  _AssessmentPageState createState() => _AssessmentPageState();
}

class _AssessmentPageState extends State<AssessmentPage> {
  void remove(int index) {
    setState(() {
      widget.assessment.questions.remove(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: GradientAppBar(
          title: widget.assessment.title,
        ),
      ),
      drawer: Drawer(),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 5,
                  color: Colors.grey.withOpacity(0.5),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: widget.assessment.questions.map((q) {
                            return PreviewTile(
                              index: widget.assessment.questions.indexOf(q) +
                                  1, //Displays the number of the question
                              type: q.type,
                              question: q.question,
                              delete: remove,
                            );
                          }).toList(), //The map function maps the question to the Powerpoint style preview tiles on the left on the assessment page
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Text(
                            'Add Question',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            widget.assessment.questions.add(Question(
                                answers: null,
                                question: null,
                                rightAnswer: null,
                                type: null,
                                points: null));
                          });
                        },
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Text(
                          'Question Bank',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Text(
                          'Import spreadsheet',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AssessmentPanel(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}