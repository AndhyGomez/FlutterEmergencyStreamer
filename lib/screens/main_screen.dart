import 'dart:async';
import 'package:EmergencyStreamer/backend/User.dart';
import 'package:EmergencyStreamer/backend/backend.dart';
import 'package:EmergencyStreamer/screens/camera_init.dart';
import 'package:EmergencyStreamer/screens/settings_screen.dart';
import 'package:camera_with_rtmp/camera.dart';
import 'package:flutter/material.dart';
import 'package:EmergencyStreamer/constants.dart';
import 'package:flutter_sms/flutter_sms.dart';

class MainScreen extends StatefulWidget {
  static final String id = 'mainScreen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isRecording = false;
  CameraController cameraController = getCamera();
  final User loggedInUser = BackEnd.getLocalUser();
  var _timer;

  Color _recordButtonColor = kRecordingInactive;

  @override
  void initState() {
    super.initState();
  }

  void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
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
      var url = myUrl + BackEnd.getCurrentUserEmail();
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
        automaticallyImplyLeading: false,
        leading: null,
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: kRedAccents,
            ),
            onPressed: () {
              // _auth.signOut();
              Navigator.pushNamed(context, SettingsScreen.id);
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
                    _sendSMS(
                        "Watch me at: " + streamUrl, loggedInUser.contacts);
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
