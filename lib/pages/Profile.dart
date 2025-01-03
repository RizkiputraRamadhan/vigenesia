import 'package:flutter/material.dart';
import 'package:vigenesia/API/Posts.dart';
import 'package:vigenesia/API/Users.dart';
import 'package:vigenesia/Components/AddPost.dart';
import 'package:vigenesia/Components/EditPost.dart';
import 'package:vigenesia/Components/NavBar.dart';
import 'package:vigenesia/utils/BottomNavItem.dart';
import 'package:vigenesia/utils/global.color.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _menus = 2;
  String finalId = '';
  String finalName = '';
  String finalFollowerCount = '';
  String finalFollowingCount = '';
  int finalPostCount = 0;
  List<dynamic> finalPostData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadPostData();
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
        finalId = profileData['user']['id']?.toString() ?? '';
        finalName = profileData['user']['username']?.toString() ?? '';
        finalFollowerCount = profileData['follower_count']?.toString() ?? '';
        finalFollowingCount = profileData['following_count']?.toString() ?? '';
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
      final postData = await PostsService.getMyPost();
      setState(() {
        finalPostData = postData['posts'];
        finalPostCount = postData['posts'].length;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching data: $e");
    }
  }

  // post content
  Future<void> _handlePostContent(String content) async {
    try {
      final response = await PostsService.storePost(content);
      if (response['status'] == 201) {
        _loadPostData();
        _showSnackBar('Berhasil menambahkan postingan', true);
      } else {
        _showSnackBar(
            'Gagal menambahkan postingan: ${response['message']}', false);
      }
    } catch (e) {
      _showSnackBar('Terjadi kesalahan saat menambahkan postingan', false);
    }
  }

  Future<void> _handleEditContent(id, String updatedContent) async {
    try {
      final response = await PostsService.updatePost(id, updatedContent);
      if (response['status'] == 201) {
        _loadPostData();
        _showSnackBar('Berhasil memperbarui postingan', true);
      } else {
        _showSnackBar(
            'Gagal memperbarui postingan: ${response['message']}', false);
      }
    } catch (e) {
      _showSnackBar('Terjadi kesalahan saat mengedit postingan', false);
    }
  }

  // Delete content
  Future<void> _handleDeleteContent(id) async {
    try {
      final response = await PostsService.deletePost(id);
      if (response['status'] == 200) {
        _loadPostData();
        _showSnackBar('Berhasil menghapus postingan', true);
      } else {
        _showSnackBar(
            'Gagal menghapus postingan: ${response['message']}', false);
      }
    } catch (e) {
      _showSnackBar('Terjadi kesalahan saat mengedit post', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomNavbar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  color: GlobalColors.mainColor,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('assets/images/user.png'),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        finalName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                finalFollowerCount,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const Text(
                                'Followed',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 30),
                          Column(
                            children: [
                              Text(
                                finalFollowingCount,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const Text(
                                'Following',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 30),
                          Column(
                            children: [
                              Text(
                                finalPostCount.toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'My Post',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
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
        ],
      ),
      floatingActionButton: Positioned(
        bottom: 16,
        right: 16,
        top: 16,
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return AddPostModal(
                  onSubmit: (content) {
                    _handlePostContent(content);
                  },
                );
              },
            );
          },
          backgroundColor: GlobalColors.mainColor,
          child: const Icon(Icons.add, color: Colors.white),
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
                              leading: const Icon(Icons.edit_outlined),
                              title: const Text('Edit Postingan'),
                              onTap: () {
                                Navigator.pop(context);
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom,
                                        left: 16,
                                        right: 16,
                                        top: 16,
                                      ),
                                      child: EditPostModal(
                                        initialContent: feedText,
                                        onSubmit: (updatedContent) {
                                          _handleEditContent(
                                              id, updatedContent);
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.delete_outline),
                              title: const Text('Delete Postingan'),
                              onTap: () {
                                Navigator.pop(context);
                                _handleDeleteContent(id);
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
