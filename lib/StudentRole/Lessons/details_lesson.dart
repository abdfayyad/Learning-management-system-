import 'package:first/StudentRole/Lessons/bloc/cubit.dart';
import 'package:first/StudentRole/Lessons/bloc/status.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class DetailsLessonStudent extends StatefulWidget {
  final Lessons? lessons;

  DetailsLessonStudent(this.lessons);

  @override
  _DetailsLessonStudentState createState() => _DetailsLessonStudentState();
}

class _DetailsLessonStudentState extends State<DetailsLessonStudent> {

  late bool isPlaying = false;
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(
        '${widget.lessons!.videoUrl}',
      ),
    );
  }

  bool _showMore = true;

  void _toggleShowMore() {
    setState(() {
      _showMore = !_showMore;
    });
  }
  String get _lessonDescription => widget.lessons?.description ?? '';

  String get string => _lessonDescription;

  @override
  Widget build(BuildContext context1) {
    return BlocProvider(create: (BuildContext context)=>LessonsStudentCubit(),
      child: BlocConsumer<LessonsStudentCubit,LessonsStudentStatus>(
        listener: (state,context){},
        builder: (state,context){
          return Scaffold(
            appBar: AppBar(
              title: Text('Lesson Details', style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.deepPurple,

            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: FlickVideoPlayer(flickManager: flickManager),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[50],
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Course:${widget.lessons!.title}',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Title: ${widget.lessons!.title}',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        _showMore ? string : string,
                        maxLines: _showMore ? 2 : null,
                        overflow: _showMore ? TextOverflow.ellipsis : TextOverflow.visible,
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: _toggleShowMore,
                    child: Text(
                      _showMore ? 'Show more' : 'Show less',
                      style: TextStyle(color: Colors.deepPurple),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: Text("Are you sure you want to delete this lesson?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Perform delete operation here
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
