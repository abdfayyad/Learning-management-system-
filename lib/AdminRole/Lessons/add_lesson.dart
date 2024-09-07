import 'dart:io';
import 'dart:convert';
import 'package:first/Const/end_point.dart';
import 'package:first/Const/shared_prefirance.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:first/AdminRole/Home/home_page.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

class AddLesson extends StatefulWidget {
  @override
  _AddLessonState createState() => _AddLessonState();
  int? id;

  AddLesson(this.id);
}

class _AddLessonState extends State<AddLesson> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  VideoPlayerController? _controller;
  final picker = ImagePicker();
  File? _image;

  late File _videoFile;

  Future<void> _pickVideo() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      _videoFile = File(pickedFile.path);
      _controller = VideoPlayerController.file(_videoFile)
        ..initialize().then((_) {
          setState(() {});
          _controller!.play();
        });
    }
  }

  Future<void> addLesson(String title, String description,String startDate, File video) async {
    final String apiUrl =
        "$BASE_URL/api/teacher/courses/${widget.id}/lessons"; // Replace with your API URL

    // Create a multipart request
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl))
      ..headers['Authorization'] =
          'Bearer ${SharedPref.getData(key: 'token')}' // Add your header here
      ..headers['Accept'] = 'application/json' // Example of content type header
      ..fields['title'] = title
      ..fields['description'] = description
      ..fields['start_date']=startDate
      ..files.add(await http.MultipartFile.fromPath(
        'video',
        video.path,
        contentType: MediaType('video', 'mp4'), // Adjust the media type according to your requirements
      ));

    // Send the request and get the response
    var response = await request.send();

    // Reading the response body as a string
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      print('Lesson added successfully');
    } else {
      print('Failed to add lesson: ${response.statusCode}');
      print('Response: $responseBody');
    }
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  DateTime? _endDate;
  DateTime? _startDate;

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Lesson', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickVideo,
        tooltip: 'Select a Video',
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Center(
                child: _controller != null && _controller!.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _controller!.value.aspectRatio,
                        child: VideoPlayer(_controller!),
                      )
                    : Text('Select a video'),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Start Date',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _startDate != null
                      ? Text('${_startDate!.toString().substring(0, 10)}')
                      : ElevatedButton(
                          onPressed: () => _selectDate(context, true),
                          child: Text('Select'),
                        ),
                ],
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(
                    left: 0, top: 0.0, right: 0.0, bottom: 0.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(2.0),
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height,
                    maxWidth: MediaQuery.of(context).size.width,
                  ),
                  child: TextField(
                    cursorColor: Colors.black,
                    cursorWidth: 2,
                    controller: _descriptionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 4,
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: "Description",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_controller != null &&
                      _titleController.text.isNotEmpty &&
                      _descriptionController.text.isNotEmpty) {
                    await addLesson(_titleController.text,
                        _descriptionController.text,_startDate.toString(), _videoFile);
                    print(_titleController.text);
                    print(_descriptionController.text);

                    print(_titleController.text);
                    // Navigate to HomePageAdmin after successful submission
                    // Navigator.pushAndRemoveUntil(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => HomePageAdmin()),
                    //   (route) => false,
                    // );
                  } else {
                    // Show error if fields are not properly filled
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              'Please fill all fields and select a video')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.deepPurple, // Text color
                ),
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
