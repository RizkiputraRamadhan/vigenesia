import 'package:flutter/material.dart';
import 'package:vigenesia/API/Posts.dart';
import 'package:vigenesia/API/Users.dart';
import 'package:vigenesia/Components/NavBar.dart';
import 'package:vigenesia/Helpers/Sessions.dart';
import 'package:vigenesia/utils/BottomNavItem.dart';
import 'package:vigenesia/utils/global.color.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _menus = 0;
  bool isLoading = true;
  String finalFollowerCount = '';
  List<dynamic> finalUserFollowers = [];
  List<dynamic> finalPostData = [];

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadPostData();
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

// Load data auth
  Future<void> _loadUserData() async {
    try {
      final profileData = await UsersService.getProfile();
      setState(() {
        finalFollowerCount = profileData['following_count']?.toString() ?? '';
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching data: $e");
    }
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

  Future<void> _loadPostData() async {
    try {
      final postData = await PostsService.getFollowedPost();
      setState(() {
        finalPostData = postData['posts'];
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
      _loadPostData();
      _showSnackBar(postData['message'], true);
    } catch (e) {
      _showSnackBar(postData['message'], true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (finalFollowerCount == '0') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, '/no_friends');
      });
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomNavbar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: finalUserFollowers.isEmpty
                          ? const [Text('Belum ada teman')]
                          : finalUserFollowers.map((follow) {
                              return makeStory(
                                userImage: 'assets/images/user.png',
                                userName: follow['username'],
                              );
                            }).toList(),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/no_friends');
                          },
                          child: Container(
                            width: 58,
                            height: 58,
                            decoration: BoxDecoration(
                              color: GlobalColors.mainColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Tambah Teman',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: finalPostData.isEmpty
                    ? const [Text("Belum ada postingan")]
                    : finalPostData.map((post) {
                        return makePost(
                          context: context,
                          id: post['id'],
                          userName: post['user']['username'],
                          userImage: 'assets/images/user.png',
                          feedTime: post['created_at'],
                          feedText: post['status'],
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

  Widget makeStory({required String userImage, required String userName}) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      width: 80,
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(userImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            userName,
            style: TextStyle(fontSize: 12, color: Colors.black),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget makePost({
    required BuildContext context,
    required int id,
    required String userName,
    required String userImage,
    required String feedTime,
    required String feedText,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
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
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        feedTime,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.more_horiz, color: Colors.black),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        padding: const EdgeInsets.all(20),
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
          const SizedBox(height: 10),
          Text(
            feedText,
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
