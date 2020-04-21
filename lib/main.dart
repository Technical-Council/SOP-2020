

import 'package:flutter/material.dart';

// Files imported
import 'package:inductions_20/screens/announcement.dart';
import 'package:inductions_20/screens/comments.dart';
import 'package:inductions_20/screens/mentee_home.dart';
import 'package:inductions_20/screens/task.dart';
import 'package:inductions_20/screens/feedbacks.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Spider Orientation',
      debugShowCheckedModeBanner: false,
      initialRoute: '/mentee/',
      routes: {
        '/mentee/': (context) => homepage("VishalS99"),
        '/mentee/task/': (context) => TASK(),
        '/mentee/task_feedback/':(context)=> TASKfeedback(),
     //   '/mentee/announcement/':(context) => Announcement(),
        '/mentee/task_comments/': (context) => TASKcomments()
      },
    ),
  );
}
