import 'package:flutter/material.dart';
import 'package:vigenesia/API/Users.dart';
import 'package:vigenesia/Components/NavBar.dart';
import 'package:vigenesia/utils/BottomNavItem.dart';

class FollowingPage extends StatefulWidget {
  const FollowingPage({Key? key}) : super(key: key);

  @override
  _FollowingPageState createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {
  int _menus = 1;
  bool isLoading = true;
  List<dynamic> finalUserFollowers = [];

  @override
  void initState() {
    super.initState();
    _loadFollowerData();
  }

  void _showSnackBar(String message, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
      ),
    );
  }

  Future<void> _loadFollowerData() async {
    try {
      final userFollow = await UsersService.UserFollowers();
      setState(() {
        finalUserFollowers = userFollow['data'];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching data: $e");
    }
  }

  Future<void> _handleUnfollow(username) async {
    final postData = await UsersService.UnFollowByUsername(username);
    try {
      _loadFollowerData();
      _showSnackBar(postData['message'], true);
    } catch (e) {
      _showSnackBar(postData['message'], true);
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
                  children: finalUserFollowers.isEmpty
                      ? const [Text('Belum ada teman')]
                      : finalUserFollowers.map((follow) {
                          return FollowerProfile(
                            context: context,
                            userName: follow['username'],
                            userImage: 'assets/images/user.png',
                            feedTime: follow['created_at'],
                          );
                        }).toList()),
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
                        'Mengikuti ${feedTime}',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                icon: Icon(Icons.more_horiz, color: Colors.black),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: Icon(Icons.person_off),
                              title: Text('Unfollow'),
                              onTap: () {
                                Navigator.pop(context);
                                _handleUnfollow(userName);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
