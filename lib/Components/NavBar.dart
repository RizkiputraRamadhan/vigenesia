import 'package:flutter/material.dart';
import 'package:vigenesia/Helpers/Sessions.dart';
import 'package:vigenesia/utils/global.color.dart';

class CustomNavbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomNavbar({Key? key}) : super(key: key);

  void _handleLogout(BuildContext context) {
    Sessions.clearAllSessions();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Vigenesia',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () => _handleLogout(context),
          color: Colors.white,
        ),
      ],
      elevation: 4.0,
      backgroundColor: GlobalColors.mainColor,
      bottom: PreferredSize(
        child: Container(),
        preferredSize: Size.fromHeight(0),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
