import 'package:flutter/material.dart';
import 'package:vigenesia/Components/AddPost.dart';
import 'package:vigenesia/utils/BottomNavItem.dart'; // Import BottomNavItem

class MyPostPages extends StatefulWidget {
  const MyPostPages({Key? key}) : super(key: key);

  @override
  _MyPostPageState createState() => _MyPostPageState();
}

class _MyPostPageState extends State<MyPostPages> {
  bool _isSearching = false;
  int _menus = 2;
  bool isBold = false;
  bool isItalic = false;

  @override
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
              ? TextField(
                  key: ValueKey('searchField'),
                  decoration: InputDecoration(
                    hintText: 'Cari...',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  style: TextStyle(color: Colors.black),
                  autofocus: true,
                )
              : Text(
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                        feedText:
                            'Me encanta la sesión de fotos que me hizo mi amigo. 🌟😍',
                      ),
                      makePost(
                        context: context,
                        userName: 'Daniela Fernández Ramos',
                        userImage: 'assets/images/user.png',
                        feedTime: '3 hours ago',
                        feedText:
                            'Me encanta la sesión de fotos que me hizo mi amigo. 🌟😍',
                      ),
                      makePost(
                        context: context,
                        userName: 'Daniela Fernández Ramos',
                        userImage: 'assets/images/user.png',
                        feedTime: '3 hours ago',
                        feedText:
                            'Me encanta la sesión de fotos que me hizo mi amigo. 🌟😍',
                      ),
                      makePost(
                        context: context,
                        userName: 'Daniela Fernández Ramos',
                        userImage: 'assets/images/user.png',
                        feedTime: '3 hours ago',
                        feedText:
                            'Me encanta la sesión de fotos que me hizo mi amigo. 🌟😍',
                      ),
                      makePost(
                        context: context,
                        userName: 'Daniela Fernández Ramos',
                        userImage: 'assets/images/user.png',
                        feedTime: '3 hours ago',
                        feedText:
                            'Me encanta la sesión de fotos que me hizo mi amigo. 🌟😍',
                      ),
                      makePost(
                        context: context,
                        userName: 'Daniela Fernández Ramos',
                        userImage: 'assets/images/user.png',
                        feedTime: '3 hours ago',
                        feedText:
                            'Me encanta la sesión de fotos que me hizo mi amigo. 🌟😍',
                      ),
                      makePost(
                        context: context,
                        userName: 'Daniela Fernández Ramos',
                        userImage: 'assets/images/user.png',
                        feedTime: '3 hours ago',
                        feedText:
                            'Me encanta la sesión de fotos que me hizo mi amigo. 🌟😍',
                      ),
                      makePost(
                        context: context,
                        userName: 'Daniela Fernández Ramos',
                        userImage: 'assets/images/user.png',
                        feedTime: '3 hours ago',
                        feedText:
                            'Me encanta la sesión de fotos que me hizo mi amigo. 🌟😍',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                        left: 16,
                        right: 16,
                        top: 16,
                      ),
                      child: AddPostModal(
                        onSubmit: (content) {
                          print('konten : $content');
                        },
                      ),
                    );
                  },
                );
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
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
