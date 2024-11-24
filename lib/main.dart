import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart'; // Correct import
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google ML Kit Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker _picker = ImagePicker();
  List<File> _images = [];
  List<String> _labelsList = []; 

  // This defines the pastel peach color used for the buttons
  final Color pastelPeach = Color(0xFFffccbc);


  // This is the function that allows the user to choose a single image from their respective gallery/photos
  Future<void> _pickSingleImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _images = [File(pickedFile.path)]; // Store only one image
        _labelsList = ["Processing..."]; // Initialize the labels list for the single image
      });

      // The command below processes the selected image once chosen
      await _labelImage(_images[0], 0); // Processes said image
    }
  }


  // Below is the function that allows the user to select from multiple images in their respective gallery/photos
  Future<void> _pickMultipleImages() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      setState(() {
        _images = pickedFiles.map((file) => File(file.path)).toList();
        _labelsList = List.generate(_images.length, (index) => "Processing..."); // Initialize labels list
      });

      // Process each selected image
      for (var i = 0; i < _images.length; i++) {
        await _labelImage(_images[i], i); // Pass index to update the correct label in _labelsList
      }
    }
  }


  // The function belows allows for the use of google_mlkit_image_labeling
  Future<void> _labelImage(File imageFile, int index) async {
    try {
      final inputImage = InputImage.fromFile(imageFile);
      final options = ImageLabelerOptions();
      final imageLabeler = ImageLabeler(options: options);

      final List<ImageLabel> labels = await imageLabeler.processImage(inputImage);

      // This section of code below contains the labels that are defined by the ml kit, it displays their name and confidence of accuracy
      String labelText = "Labels:\n";
      for (ImageLabel label in labels) {
        labelText += "${label.label} (${(label.confidence * 100).toStringAsFixed(2)}%)\n";
      }

      
      setState(() {
        _labelsList[index] = labelText; // Update labels list at the correct index
      });

      
      imageLabeler.close();
    } catch (e) {
      setState(() {
        _labelsList[index] = "Error processing image: $e"; // Update with error message
      });

    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Labeling"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Display the selected images side by side
            _images.isEmpty
                ? Text("No image selected yet.")
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(_images.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          
                          child: Column(
                            children: [
                              // Image Container with fixed size, to prevent the image from taking a majority portion of the screen
                              Container(
                                width: 150, //
                                height: 150,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: FileImage(_images[index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),

                              // Label Box for each image with scrollable labels

                              // This container is used to create a scrollable box to display all labels produced by the ml kit
                              Container(
                                width: 150,
                                height: 120,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white, 
                                  borderRadius: BorderRadius.circular(10), 
                                  border: Border.all(color: Colors.grey), 
                                ),
                                child: SingleChildScrollView(
                                  child: Text(
                                    _labelsList[index], 
                                    style: TextStyle(fontSize: 14, color: Colors.black), 
                                    overflow: TextOverflow.ellipsis, 
                                  ),
                                ),
                              ),

                            ],
                          ),
                        );
                      }),
                    ),
                  ),


            SizedBox(height: 20),
            // Contains the buttons to allow the user to choose from one or multiple images
            ElevatedButton(
              onPressed: _pickSingleImage,
              style: ElevatedButton.styleFrom(
                
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero), 
                backgroundColor: pastelPeach, 
              ),
              
              child: Text(
                "Choose a Single Image",
                style: TextStyle(color: Colors.black),
              ),

            ),


            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickMultipleImages,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero), 
                backgroundColor: pastelPeach, 

              ),

              child: Text(
                "Choose Multiple Images",
                style: TextStyle(color: Colors.black), 
              ),

            ),


          ],
        ),
      ),
    );
  }
}
