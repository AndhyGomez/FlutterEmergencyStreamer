import 'package:camera_with_rtmp/camera.dart';

CameraController _controller;
List<CameraDescription> _cameras;

Future<void> initCameras() async {
  _cameras = await availableCameras();
  _controller = CameraController(_cameras[0], ResolutionPreset.high);
  _controller.initialize().then((_) {
    print("Camera Initialized");
  });
}

CameraController getCamera() => _controller;

List<CameraDescription> getCameras() => _cameras;

CameraController switchCamera(CameraDescription newCam) {
  disposeController();
  _controller = CameraController(newCam, ResolutionPreset.high);
  _controller.initialize().then((_) {
    print("Controller changed to camera: " + newCam.toString());
  });
  return _controller;
}

void disposeController() {
  _controller?.dispose();
}
