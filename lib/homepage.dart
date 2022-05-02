import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CameraController _cameraController;
  bool isCameraAvailable = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Assignment"),
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: isCameraAvailable
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      height: 300,
                      width: 300,
                      child: CameraPreview(_cameraController)),
                ),
              )
            : Center(
                child: ElevatedButton(
                    onPressed: () async {
                      await availableCameras().then((value) {
                        _cameraController =
                            CameraController(value[0], ResolutionPreset.max);
                        isCameraAvailable = true;
                      });
                      _cameraController.initialize().then((value) {
                        setState(() {
                          if (!mounted) {
                            setState(() {
                              isCameraAvailable = true;
                            });
                          }
                        });
                      });
                    },
                    child: Text("Scan")),
              ));
  }
}
