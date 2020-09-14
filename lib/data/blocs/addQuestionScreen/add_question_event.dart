part of 'add_question_bloc.dart';

@immutable
abstract class AddQuestionEvent {}

class AddQuestion extends AddQuestionEvent {
  final QuestionType questionType;

  AddQuestion(this.questionType);
}

class UploadExcel extends AddQuestionEvent {
  final FilePickerCross file;

  UploadExcel(this.file);
}
