import 'package:flutter/material.dart';

class Botnavbar extends StatelessWidget {
  final ValueChanged<int> ItemTapped;
  final int index;

  const Botnavbar({
    super.key,
    required this.ItemTapped,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: ItemTapped,
      currentIndex: index,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera_alt),
          label: 'Predict',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
