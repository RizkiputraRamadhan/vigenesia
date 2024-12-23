import 'package:flutter/material.dart';
import 'package:vigenesia/utils/BottomNavItem.dart'; // Import BottomNavItem

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSearching = false;
  int _menus = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: _isSearching
            ? IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  setState(() {
                    _isSearching = false;
                  });
                },
              )
            : null,
        title: AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: _isSearching
              ? const TextField(
                  key: ValueKey('searchField'),
                  decoration: InputDecoration(
                    hintText: 'Cari...',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  style: TextStyle(color: Colors.black),
                  autofocus: true,
                )
              : const Text(
                  'VGS',
                  key: ValueKey('title'),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
        actions: [
          if (!_isSearching)
            IconButton(
              icon: Icon(Icons.search, color: Colors.black),
              onPressed: () {
                setState(() {
                  _isSearching = true;
                });
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stories Section
            Container(
              height: 120,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  makeStory(userImage: 'assets/images/user.png', userName: 'Your Story'),
                  makeStory(userImage: 'assets/images/user.png', userName: 'James'),
                  makeStory(userImage: 'assets/images/user.png', userName: 'Fernanda'),
                  makeStory(userImage: 'assets/images/user.png', userName: 'Daniela'),
                ],
              ),
            ),

            // Posts Section
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  makePost(
                    context: context,
                    userName: 'Daniela Fernández Ramos',
                    userImage: 'assets/images/user.png',
                    feedTime: '3 hours ago',
                    feedText: 'Me encanta la sesión de fotos que me hizo mi amigo. 🌟😍',
                  ),
                  makePost(
                    context: context,
                    userName: 'James Collins',
                    userImage: 'assets/images/user.png',
                    feedTime: '5 hours ago',
                    feedText: 'Had an amazing weekend with friends!',
                  ),
                  makePost(
                    context: context,
                    userName: 'James Collins',
                    userImage: 'assets/images/user.png',
                    feedTime: '5 hours ago',
                    feedText: 'Had an amazing weekend with friends!',
                  ),
                ],
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
    required String userName,
    required String userImage,
    required String feedTime,
    required String feedText,
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
                        feedTime,
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
                              leading: Icon(Icons.person_add_alt_1_outlined),
                              title: Text('Follow/Unfollow'),
                              onTap: () {},
                            ),
                            ListTile(
                              leading: Icon(Icons.edit_outlined),
                              title: Text('Edit Post'),
                              onTap: () {},
                            ),
                            ListTile(
                              leading: Icon(Icons.delete_outline),
                              title: Text('Delete Post'),
                              onTap: () {},
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
          SizedBox(height: 10),
          Text(
            feedText,
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
  