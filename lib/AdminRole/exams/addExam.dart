import 'package:first/AdminRole/Home/home_page.dart';
import 'package:first/Const/end_point.dart';
import 'package:first/Const/shared_prefirance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddExamScreen extends StatefulWidget {
  int? id;

  AddExamScreen({required this.id});

  @override
  _AddExamScreenState createState() => _AddExamScreenState();
}

class _AddExamScreenState extends State<AddExamScreen> {
  List<Question> questions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Exam Questions'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                questions.add(Question());
              });
            },
            child: Text('Add Question'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return QuestionWidget(
                  question: questions[index],
                  questionNumber: index + 1,
                  onDelete: () {
                    setState(() {
                      questions.removeAt(index);
                    });
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              submitExam();

            },
            child: Text('Submit Exam'),
          ),
        ],
      ),
    );
  }
  Future<void> submitExam() async {
    final url = '$BASE_URL/api/teacher/courses/${widget.id}/add_exam';
    print(url);

    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',  // Ensure the Content-Type is set to application/json
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
    };

    final body = {
      "exam": {
        "title": "Exam description",
        "questions": questions.map((q) {
          int correctOption = q.isOption1Correct
              ? 1
              : q.isOption2Correct
              ? 2
              : 3;
          return {
            "question_text": q.text,
            "1": q.option1,
            "2": q.option2,
            "3": q.option3,
            "is_correct": correctOption,
          };
        }).toList(),
      }
    };

    // Convert body to JSON string for proper format
    final jsonBody = json.encode(body);
    print(jsonBody);  // This will print the correctly formatted JSON string

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonBody,  // Send the JSON string as the body
    );

    if (response.statusCode == 200) {
      print('Exam submitted successfully');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('success to add Exam')));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePageAdmin()),
            (Route<dynamic> route) => false, // This removes all the previous routes
      );
      print(response.body);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('failed to add Exam')));

      print('Failed to submit exam: ${response.body}');
      print(response.statusCode);
    }
  }



  void printQuestions() {
    for (int i = 0; i < questions.length; i++) {
      print("id:${i + 1}");
      print('question_text : ${questions[i].text}');
      print('1: ${questions[i].option1} (${questions[i].isOption1Correct ? 'Correct' : 'Incorrect'})');
      print('2: ${questions[i].option2} (${questions[i].isOption2Correct ? 'Correct' : 'Incorrect'})');
      print('3: ${questions[i].option3} (${questions[i].isOption3Correct ? 'Correct' : 'Incorrect'})');
      print('');
    }
  }
}

class Question {
  String text;
  String option1;
  String option2;
  String option3;
  bool isOption1Correct = false;
  bool isOption2Correct = false;
  bool isOption3Correct = false;

  Question({
    this.text = '',
    this.option1 = '',
    this.option2 = '',
    this.option3 = '',
  });
}

class QuestionWidget extends StatefulWidget {
  final Question question;
  final int questionNumber;
  final VoidCallback onDelete;

  QuestionWidget({required this.question, required this.questionNumber, required this.onDelete});

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Question ${widget.questionNumber}:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              labelText: 'Question',
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 2.0),
              ),
            ),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            onChanged: (value) {
              widget.question.text = value;
            },
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "1-",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Option 1',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    widget.question.option1 = value;
                  },
                ),
              ),
              Radio<String>(
                value: 'option1',
                groupValue: selectedOption,
                onChanged: (String? value) {
                  setState(() {
                    selectedOption = value;
                    widget.question.isOption1Correct = true;
                    widget.question.isOption2Correct = false;
                    widget.question.isOption3Correct = false;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "2-",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Option 2',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    widget.question.option2 = value;
                  },
                ),
              ),
              Radio<String>(
                value: 'option2',
                groupValue: selectedOption,
                onChanged: (String? value) {
                  setState(() {
                    selectedOption = value;
                    widget.question.isOption1Correct = false;
                    widget.question.isOption2Correct = true;
                    widget.question.isOption3Correct = false;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "3-",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Option 3',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    widget.question.option3 = value;
                  },
                ),
              ),
              Radio<String>(
                value: 'option3',
                groupValue: selectedOption,
                onChanged: (String? value) {
                  setState(() {
                    selectedOption = value;
                    widget.question.isOption1Correct = false;
                    widget.question.isOption2Correct = false;
                    widget.question.isOption3Correct = true;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: widget.onDelete,
                child: Icon(Icons.delete),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
