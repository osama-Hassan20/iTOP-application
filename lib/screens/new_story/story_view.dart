
import 'package:flutter/material.dart';
import 'dart:async';

class MyStoryPage extends StatefulWidget {
  final String storyImagePath;
  final String name;
  final String imagePath;

  MyStoryPage({
    required this.storyImagePath,
    required this.name,
    required this.imagePath,
  });
  @override
  _MyStoryPageState createState() => _MyStoryPageState();
}

class _MyStoryPageState extends State<MyStoryPage> {
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    Timer.periodic(Duration(milliseconds: 1), (timer) {
      setState(() {
        _progress += 1.0 / 1000.0;
      });

      if (_progress >= 1.0) {
        timer.cancel();
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: SizedBox(),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [



          LinearProgressIndicator(
            value: _progress,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Row(
            children: [
              const SizedBox(
                width: 15.0,
              ),
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 32.0,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage:  NetworkImage('${widget.imagePath}'),
                  radius: 30.0,
                ),
              ),
              const SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      '${widget.name}',
                      style: const TextStyle(
                          height: 1.4,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        color: Colors.white
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    const Icon(
                      Icons.public,
                      color: Colors.white,
                      size: 16.0,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 15.0,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 32.0,
                ),
              ),
            ],
          ),
          Spacer(),
          Center(
            child: Hero(
              tag: 'imageHero', // تعيين علامة لـ Hero لإظهار الصورة كاملة الشاشة بشكل سلس عند النقر
              child: Image.network(widget.storyImagePath), // استخدام الصورة من الشبكة كمثال، يمكنك استبدالها بمسار محلي إذا لزم الأمر
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
// Container(
// height: double.infinity,
// width: double.infinity,
// child: Image.network(widget.storyImagePath,fit: BoxFit.fill),
// ),




