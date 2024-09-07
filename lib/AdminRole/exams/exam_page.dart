import 'package:first/Const/end_point.dart';
import 'package:first/Const/shared_prefirance.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SolveExamTeacher extends StatefulWidget {
  @override
  _SolveExamTeacherState createState() => _SolveExamTeacherState();
  SolveExamTeacher({required this.id});
  final int? id;
}

class _SolveExamTeacherState extends State<SolveExamTeacher> {
  List<Question> questions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    try {
      final response = await http.get(Uri.parse('$BASE_URL/api/teacher/exams/${widget.id}'),headers:  {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
      });
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          questions = (data['questions'] as List).map((questionData) {
            return Question(
              id: questionData['id'],
              value: questionData['question_text'],
              choice1: questionData['1'],
              choice2: questionData['2'],
              choice3: questionData['3'],
              correctChoice: questionData['is_correct'],
            );
          }).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load questions');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
      // Optionally show an error message to the user
    }
  }

  String getCorrectAnswer(Question question) {
    switch (question.correctChoice) {
      case 1:
        return question.choice1;
      case 2:
        return question.choice2;
      case 3:
        return question.choice3;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          'Exam Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Question ${questions[index].id}: ${questions[index].value}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Option 1: ${questions[index].choice1}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.purpleAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Option 2: ${questions[index].choice2}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.purpleAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Option 3: ${questions[index].choice3}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.purpleAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Correct Answer: ${getCorrectAnswer(questions[index])}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Question {
  final int id;
  final String value;
  final String choice1;
  final String choice2;
  final String choice3;
  final int correctChoice;

  Question({
    required this.id,
    required this.value,
    required this.choice1,
    required this.choice2,
    required this.choice3,
    required this.correctChoice,
  });
}
