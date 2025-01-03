import 'package:flutter/material.dart';
import 'package:vigenesia/utils/global.color.dart';

class BottomNavItem extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavItem({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(currentIndex: currentIndex, type: BottomNavigationBarType.fixed,
      selectedItemColor: GlobalColors.mainColor, 
      unselectedItemColor: const Color.fromARGB(255, 36, 36, 36),
      backgroundColor: Colors.white,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_outlined,
            color: currentIndex == 0 ? GlobalColors.mainColor : const Color.fromARGB(255, 36, 36, 36),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.group_outlined,
            color: currentIndex == 1 ? GlobalColors.mainColor : const Color.fromARGB(255, 36, 36, 36),
          ),
          label: 'Following',
        ),
      
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person_2_outlined,
            color: currentIndex == 2 ? GlobalColors.mainColor : const Color.fromARGB(255, 36, 36, 36),
          ),
          label: 'Profile',
        ),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/home');
            break;
          case 1:
            Navigator.pushReplacementNamed(context, '/following');
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/profile');
            break;
        }
      },
    );
  }
}
