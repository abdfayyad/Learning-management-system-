import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Player Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VideoList(),
    );
  }
}

class VideoList extends StatelessWidget {
  final List<Map<String, dynamic>> lessons = [
    {
      "id": 1,
      "lesson_title": "lesson_39",
      "lesson_video": "http://192.168.232.182:8000/videos/video_1718136192.mp4",
      "start_date": "2003-01-09",
      "course_title": "Database2",
      "description": "Ipsum omnis."
    },
    {
      "id": 2,
      "lesson_title": "lesson_11",
      "lesson_video": "http://www.altenwerth.net/aut-sunt-eveniet-et-rerum-aut-sed-molestias-est.html",
      "start_date": "1973-12-05",
      "course_title": "Object Oriented Programming",
      "description": "Autem sed."
    },
    {
      "id": 3,
      "lesson_title": "lesson_89",
      "lesson_video": "http://bechtelar.biz/aut-eligendi-eos-voluptas-ut-dolores-consectetur",
      "start_date": "1996-01-02",
      "course_title": "Automata theory",
      "description": "Modi aliquid."
    },
    {
      "id": 10,
      "lesson_title": "lesson_67",
      "lesson_video": "http://www.beatty.org/beatae-quam-quas-dolor-tempora-eius",
      "start_date": "2002-12-27",
      "course_title": "Database2",
      "description": "Odio ipsum et."
    },
    {
      "id": 11,
      "lesson_title": "lesson1",
      "lesson_video": "http://192.168.232.182:8000/videos/video_1718136192.mp4",
      "start_date": "2024-06-20",
      "course_title": "Database2",
      "description": "this lesson is about meals"
    },
    {
      "id": 12,
      "lesson_title": "lesson1",
      "lesson_video": "http://192.168.232.182:8000/videos/video_1718136192.mp4",
      "start_date": "2024-06-20",
      "course_title": "Database2",
      "description": "this lesson is about meals"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video List'),
      ),
      body: ListView.builder(
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(lessons[index]['lesson_title']),
            subtitle: Text(lessons[index]['description']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoPlayerScreen(
                    videoUrl: lessons[index]['lesson_video'],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerScreen({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
 late   Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
      widget.videoUrl,
    );

    _initializeVideoPlayerFuture = _controller.initialize();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
