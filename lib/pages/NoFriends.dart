import 'package:flutter/material.dart';
import 'package:vigenesia/API/Users.dart';
import 'package:vigenesia/Components/NavBar.dart';
import 'package:vigenesia/utils/BottomNavItem.dart';

class NoFriendsPage extends StatefulWidget {
  const NoFriendsPage({Key? key}) : super(key: key);

  @override
  _NoFriendsState createState() => _NoFriendsState();
}

class _NoFriendsState extends State<NoFriendsPage> {
  int _menus = 0;
  bool isLoading = true;
  List<dynamic> post = [];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _showSnackBar(String message, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
      ),
    );
  }

// Load data auth
  Future<void> _loadUserData() async {
    try {
      final datas = await UsersService.getAll();
      setState(() {
        post = datas['users'];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching data: $e");
    }
  }

  // dancle follow user
  Future<void> _handleFollow(String username) async {
    final datas = await UsersService.FollowByUsername(username);
    try {
      _loadUserData();
      _showSnackBar(datas['message'], true);
    } catch (e) {
      _showSnackBar(datas['message'], false);
    }
  }

  // handle unfollow user
  Future<void> _handleUnFollow(String username) async {
    final datas = await UsersService.UnFollowByUsername(username);
    try {
      _loadUserData();
      _showSnackBar(datas['message'], true);
    } catch (e) {
      _showSnackBar(datas['message'], false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomNavbar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Posts Section
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: post.isEmpty
                    ? const [Text("Belum ada teman disini.")]
                    : post.map((pos) {
                        return FollowerProfile(
                          context: context,
                          userName: pos['username'],
                          userImage: 'assets/images/user.png',
                          feedTime: pos['created_at'],
                        );
                      }).toList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavItem(
        currentIndex: _menus,
        onTap: (index) {
          setState(() {
            _menus = index;
          });
        },
      ),
    );
  }

// widget follwo profil
  Widget FollowerProfile({
    required BuildContext context,
    required String userName,
    required String userImage,
    required String feedTime,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(userImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Bergabung ${feedTime}',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                icon: Icon(Icons.person_add_alt, color: Colors.black),
                onPressed: () {
                  _handleFollow(userName);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
