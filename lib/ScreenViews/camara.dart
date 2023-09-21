import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Camera extends StatefulWidget {
  const Camera({Key? key}) : super(key: key);

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  File? _image;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
        title: Text('Cámara'),
        backgroundColor: Color.fromARGB(255, 11, 0, 61),
      ),
  
  bottomNavigationBar:  BottomAppBar(
      color: Color.fromARGB(255, 11, 0, 61),
      shape: const CircularNotchedRectangle(),
      child: Container(
        height: 50.0,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
      ),
    ),
  
  floatingActionButton: FloatingActionButton(
    onPressed: _takePhoto,
    tooltip: 'Tomar foto',
    backgroundColor: Color.fromARGB(255, 11, 0, 61),
    foregroundColor: const Color.fromARGB(255, 255, 255, 255),
    child: Icon(Icons.camera_alt),
  ),
  floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
  body: SingleChildScrollView(
    child: Column(
    children: [
      if (_image != null)
        Visibility(
          visible: _image != null,
          child: kIsWeb
              ? Image.network(_image!.path) 
              : Image.file(_image!), 
        ),
    ],
  ),
  ),
);

  }

  Future<void> _takePhoto() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    if (image == null) return; 

    
    setState(() {
      _image = File(image.path);
    });
  }
}