import 'dart:async';
import 'package:EmergencyStreamer/screens/camera_init.dart';
import 'package:camera_with_rtmp/camera.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:EmergencyStreamer/constants.dart';

class MainScreen extends StatefulWidget {
  static final String id = 'mainScreen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _auth = FirebaseAuth.instance;
  User loggedInUser;
  bool isRecording = false;
  CameraController cameraController = getCamera();
  var _timer;

  Color _recordButtonColor = kRecordingInactive;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> startVideoStreaming() async {
    if (!cameraController.value.isInitialized) {
      //showInSnackBar('Error: select a camera first.');
      return null;
    }

    if (cameraController.value.isStreamingVideoRtmp) {
      return null;
    }

    // Open up a dialog for the url
    String myUrl = streamUrl;

    try {
      if (_timer != null) {
        _timer.cancel();
        _timer = null;
      }
      var url = myUrl + loggedInUser.email;
      print(url);

      await cameraController.startVideoStreaming(url,
          bitrate: 3225600, androidUseOpenGL: true);
      _timer = Timer.periodic(Duration(seconds: 1), (timer) async {});
    } on CameraException catch (e) {
      print(e.code);
      //_showCameraException(e);
      return null;
    }
    return streamUrl;
  }

  Future<void> stopVideoStreaming() async {
    if (!cameraController.value.isStreamingVideoRtmp) {
      return null;
    }

    try {
      await cameraController.stopVideoStreaming();
      if (_timer != null) {
        _timer.cancel();
        _timer = null;
      }
    } on CameraException catch (e) {
      print(e);
      //_showCameraException(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: null,
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: kRedAccents,
            ),
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
            ),
            isRecording
                ? Container(
                    height: 0,
                    child: AspectRatio(
                      aspectRatio: cameraController.value.aspectRatio,
                      child: CameraPreview(cameraController),
                    ),
                  )
                : Text("Click to record"),
            SizedBox(
              height: kSpaceBetweenFields,
            ),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  if (isRecording) {
                    stopVideoStreaming();
                    _recordButtonColor = kRecordingInactive;
                  } else {
                    startVideoStreaming();
                    _recordButtonColor = kRecordingActive;
                  }
                  isRecording = !isRecording;
                });
              },
              backgroundColor: _recordButtonColor,
              elevation: 10.0,
              child: Icon(
                Icons.videocam,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
          ],
        ),
      ),
    );
  }
}
