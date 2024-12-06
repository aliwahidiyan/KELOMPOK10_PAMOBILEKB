import 'package:coffee/widget/botnavbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:coffee/screen/profile.dart'; // Import ProfileScreen
import 'package:coffee/screen/history.dart'; // Import HistoryScreen

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEF5EE),
      body: ListView(
        children: [
          Card(
            color: Color(0xFFFEFEFE),
            shadowColor: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Convolutional Neural Network',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'adalah jenis jaringan saraf tiruan yang sangat efektif dalam memproses data gambar. CNN bekerja dengan cara'
                    'mengidentifikasi pola dan fitur dalam gambar melalui operasi konvolusi dan pooling. Lapisan-lapisan'
                    'dalam CNN secara hierarkis mengekstrak fitur mulai dari yang sederhana (misal: tepi) hingga yang'
                    'kompleks (misal: wajah).',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Card(
            color: Color(0xFFFEFEFE),
            shadowColor: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Confusion Matrix',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 300,
                    child: _buildHeatmap(),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Penjelasan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _penjelasan("Baris dan Kolom",
                      "Tabel memiliki 4 baris dan 4 kolom, yang merepresentasikan 4 kelas yang berbeda, yaitu Dark, Light, Mid-Dark, dan Mid-Light."),
                  const SizedBox(height: 10),
                  _penjelasan("Nilai-nilai",
                      "Nilai-nilai dalam tabel merepresentasikan kemungkinan atau probabilitas dari setiap kelas. Nilai-nilai ini dihitung dari data pelatihan dan diplot dalam bentuk heatmap."),
                  const SizedBox(height: 10),
                  _penjelasan("Warna",
                      "Warna pada heatmap merepresentasikan nilai-nilai probabilitas. Warna biru yang lebih gelap menunjukkan nilai probabilitas yang lebih tinggi."),
                  const SizedBox(height: 10),
                  _penjelasan("Label",
                      "Label pada heatmap menunjukkan nilai probabilitas dalam bentuk persentase."),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Card(
            color: Color(0xFFFEFEFE),
            shadowColor: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Performance Metrics',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: const Text(
                          "Kelas",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        child: const Text(
                          "Precision",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        child: const Text(
                          "Recall",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        child: const Text(
                          "F1 Score",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  _buildMetricRow('Dark', '24%', '24%', '24%'),
                  _buildMetricRow('Light', '28%', '26%', '27%'),
                  _buildMetricRow('Mid-Dark', '30%', '32%', '31%'),
                  _buildMetricRow('Mid-Light', '20%', '19%', '19%'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Card(
            color: Color(0xFFFEFEFE),
            shadowColor: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Model Architecture',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Base Model: MobileNetV2',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      "images/mobilenetv2.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(height: 8),
                  Text(
                    'Layer Configuration:\n'
                    '• MobileNetV2 (pre-trained on ImageNet)\n'
                    '  - Input Shape: (224, 224, 3)\n'
                    '  - include_top: False\n'
                    '  - Weights: ImageNet\n\n'
                    'Custom Layers:\n'
                    '• GlobalAveragePooling2D\n'
                    '• Dense (1024 units, ReLU activation)\n'
                    '• Dense (4 units, Softmax activation)\n\n'
                    'Training Configuration:\n'
                    '• Optimizer: Adam (lr=0.001)\n'
                    '• Loss: Categorical Crossentropy\n'
                    '• Metrics: Accuracy\n\n'
                    'Note: Base model layers are frozen during training',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Botnavbar(
        ItemTapped: (index) {
          switch (index) {
            case 0:
              break;
            case 1:
              Navigator.pushNamed(context, '/predict');
              break;
            case 2:
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
        index: 0,
      ),
    );
  }

  Widget _penjelasan(
    String title,
    String teks,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${title} :',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Text(
          teks,
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildHeatmap() {
    // Sample confusion matrix data
    final List<List<double>> matrix = [
      [
        0.0586,
        0.0625,
        0.0776,
        0.0415,
      ],
      [
        0.0634,
        0.0708,
        0.08641,
        0.0520,
      ],
      [
        0.07344,
        0.07336,
        0.0935,
        0.0563,
      ],
      [
        0.0475,
        0.0472,
        0.0588,
        0.0363,
      ],
    ];

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      itemCount: 16,
      itemBuilder: (context, index) {
        final row = index ~/ 4;
        final col = index % 4;
        final value = matrix[row][col];

        return Container(
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(value),
            border: Border.all(color: Colors.black12),
          ),
          child: Center(
            child: Text(
              '${(value * 100).toStringAsFixed(1)}%',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMetricRow(
    String kelas,
    String metric1,
    String metric2,
    String metric3,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              kelas,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: Text(
              metric1,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              metric2,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              metric3,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
