import 'package:coffee/controller/controller.dart';
import 'package:coffee/widget/botnavbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:coffee/screen/profile.dart'; // Import ProfileScreen
import 'package:coffee/screen/history.dart';
import 'package:provider/provider.dart'; // Import HistoryScreen

class PredictionPage extends StatefulWidget {
  const PredictionPage({super.key});

  @override
  State<PredictionPage> createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  @override
  Widget build(BuildContext context) {
    final predictionProvider = Provider.of<PredictionProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFEF5EE),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 70),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Skintone AI',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Discover your perfect match',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Select Image Source'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  predictionProvider
                                      .pickImage(ImageSource.camera);
                                },
                                child: const Text('Take Photo'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  predictionProvider
                                      .pickImage(ImageSource.gallery);
                                },
                                child: const Text('Pick from Gallery'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: predictionProvider.imageFile == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: const BoxDecoration(
                                    color: Colors.brown,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Upload or Take Photo',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            )
                          : Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.file(
                                    predictionProvider.imageFile!,
                                    width: double.infinity,
                                    height: 300,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Positioned(
                                  right: 10,
                                  top: 10,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        predictionProvider.imageFile = null;
                                        predictionProvider.predictionMessage =
                                            null;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        predictionProvider.predictImage();
                      },
                      icon: Icon(Icons.upload_file),
                      label: Text('Predict'),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Your Skintone',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (predictionProvider.predictionMessage != null)
                    Container(
                        width: double.infinity,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Color(0xfffefefe),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: Row(
                            children: [
                              _skintone(
                                predictionProvider.predictionMessage!,
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Text(
                                'Warna Kulit : ',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                predictionProvider.predictionMessage!,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Botnavbar(
        ItemTapped: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, "/home");
              predictionProvider.imageFile = null;
              predictionProvider.predictionMessage = null;
              break;
            case 1:
              break;
            case 2:
              Navigator.pushNamed(context, '/profile');
              predictionProvider.imageFile = null;
              predictionProvider.predictionMessage = null;
              break;
          }
        },
        index: 1,
      ),
    );
  }

  Widget _skintone(String tone) {
    Color bgcolor = Colors.transparent;
    if (tone == "Hitam") {
      bgcolor = Colors.brown.shade700;
    } else if (tone == "Putih") {
      bgcolor = Colors.orange.shade50;
    } else if (tone == 'Sawo Matang') {
      bgcolor = Color(0xFFD2B48C);
    } else if (tone == 'Kuning Langsat') {
      bgcolor = Color(0xFFF3E5AB);
    }

    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: bgcolor,
      ),
    );
  }
}
