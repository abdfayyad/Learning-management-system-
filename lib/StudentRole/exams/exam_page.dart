import 'package:first/Const/end_point.dart';
import 'package:first/Const/shared_prefirance.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {


  Future<Map<String, dynamic>> fetchExamData(int examId) async {
    final response = await http.get(Uri.parse('$BASE_URL/api/student/exams/$examId/details'),headers:{
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    });

    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load exam data');
    }
  }

  Future<void> submitExamAnswers(int examId, Map<int, int> answers) async {
    // Convert the keys to strings
    Map<String, int> stringKeyedAnswers = answers.map((key, value) => MapEntry(key.toString(), value));

    final response = await http.post(
      Uri.parse('$BASE_URL/api/student/exams/$examId/solve'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
      },
      body: json.encode(stringKeyedAnswers),
    );

    print("Response: ${response.body}");
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.body);
      throw Exception('Failed to submit answers');
    }
  }

}


class SolveExamStudent extends StatefulWidget {
  final int id;

  SolveExamStudent({required this.id});

  @override
  _SolveExamStudentState createState() => _SolveExamStudentState();
}

class _SolveExamStudentState extends State<SolveExamStudent> {
  late Future<Map<String, dynamic>> _examData;
  final ApiService apiService = ApiService();
  Map<int, int> selectedAnswers = {};

  @override
  void initState() {
    super.initState();
    _examData = apiService.fetchExamData(widget.id);
  }

  void selectOption(int questionId, int optionIndex) {
    setState(() {
      selectedAnswers[questionId] = optionIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          'Solve Your Exam',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _examData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No data available'));
          } else {
            List<dynamic> questions = snapshot.data!['questions'];
            return ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                var question = questions[index];
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
                            'Question ${question['id']}: ${question['question_text']}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(height: 10),
                          for (int optionIndex = 0; optionIndex < 3; optionIndex++)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: OptionButton(
                                questionId: question['id'],
                                optionIndex: optionIndex,
                                text: [
                                  question['option1'],
                                  question['option2'],
                                  question['option3'],
                                ][optionIndex],
                                isSelected: selectedAnswers[question['id']] == optionIndex,
                                onTap: () => selectOption(question['id'], optionIndex),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        onPressed: () async {
          await apiService.submitExamAnswers(widget.id, selectedAnswers);
          Navigator.pop(context);
        },

        child: Text(
          'Submit',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}





class OptionButton extends StatelessWidget {
  final int questionId;
  final int optionIndex;
  final String text;
  final bool isSelected;
  final Function onTap;

  OptionButton({
    required this.questionId,
    required this.optionIndex,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: isSelected ? null : Border.all(color: Colors.black54),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
