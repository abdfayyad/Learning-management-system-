import 'dart:io';

import 'package:first/AdminRole/Home/home_page.dart';
import 'package:first/Const/end_point.dart';
import 'package:first/Const/shared_prefirance.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AddCourse extends StatefulWidget {
  const AddCourse({Key? key}) : super(key: key);

  @override
  _AddCourseState createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  File? _imageFile;
  DateTime? _startDate;
  DateTime? _endDate;
  final _courseNameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _durationController = TextEditingController();

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  Future<bool> addCourse({
    required String courseName,
    required String price,
    required String description,
    required String imagePath,
    required String duration,
    required String startDate,
    required String endDate,
  }) async {
    final uri = Uri.parse('$BASE_URL/api/teacher/courses'); // Replace with your API endpoint
    final request = http.MultipartRequest('POST', uri);

    request.fields['title'] = courseName;
    request.fields['price'] = price;
    request.fields['description'] = description;
    request.fields['duration'] = duration;
    request.fields['starting_at'] = startDate;
    request.fields['ending_at'] = endDate;

    if (imagePath.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath('course_image', imagePath));
    }
    request.headers.addAll({
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your token retrieval method
    });
    final response = await request.send();

    final responseBody = await response.stream.bytesToString(); // Convert response stream to string

    if (response.statusCode == 200) {
      print(responseBody); // Print response body
      return true;
    } else {
      print(response.statusCode);
      print(responseBody); // Print response body

      return false;
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

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Course'),
          content: Text('Are you sure you want to add this course?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Add logic to save course
                bool success = await addCourse(
                  courseName: _courseNameController.text,
                  price: _priceController.text,
                  description: _descriptionController.text,
                  duration: _durationController.text,
                  startDate: _startDate.toString(),
                  endDate: _endDate.toString(),
                  imagePath: _imageFile?.path ?? '',
                );
                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('success to add course')));
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomePageAdmin()),
                        (Route<dynamic> route) => false, // This removes all the previous routes
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add course')));

                }
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  void _showImagePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Image'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Take a picture'),
                onTap: () {
                  _getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.image),
                title: Text('Choose from gallery'),
                onTap: () {
                  _getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Course'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  _showImagePickerDialog(context);
                },
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _imageFile != null
                      ? Image.file(
                    _imageFile!,
                    fit: BoxFit.cover,
                  )
                      : Icon(
                    Icons.add_a_photo,
                    size: 50,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _courseNameController,
                decoration: InputDecoration(
                  labelText: 'Course Name',
                  hintText: 'Enter course name',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: 'Price',
                  hintText: 'Enter course price',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              TextFormField(

                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'Enter course description',
                ),
                maxLines: 3,
              ),
              SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _durationController,
                decoration: InputDecoration(
                  labelText: 'Duration',
                  hintText: 'Enter course duration',
                ),
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
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'End Date',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _endDate != null
                      ? Text('${_endDate!.toString().substring(0, 10)}')
                      : ElevatedButton(
                    onPressed: () => _selectDate(context, false),
                    child: Text('Select'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _showConfirmationDialog(context);
                },
                child: Text('Add Course'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
