// file: component/AddPost.dart
import 'package:flutter/material.dart';
import 'package:vigenesia/utils/global.color.dart';

class AddPost extends StatelessWidget {
  final Function(String content)? onSubmit;

  const AddPost({super.key, this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
                  child: AddPostModal(onSubmit: onSubmit),
                );
              },
            );
          },
          backgroundColor: GlobalColors.mainColor,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}

class AddPostModal extends StatefulWidget {
  final Function(String content)? onSubmit;

  const AddPostModal({super.key, this.onSubmit});

  @override
  _AddPostModalState createState() => _AddPostModalState();
}

class _AddPostModalState extends State<AddPostModal> {
  final TextEditingController _controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          const Text(
            'Buat Postingan Terbaru Kamu..',
            style: TextStyle(letterSpacing: 0.5,fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            maxLines: 5,
            decoration: const InputDecoration(
              hintText: 'Tulis apa yang anda dipikiranmu',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (widget.onSubmit != null) {
                widget.onSubmit!(_controller.text);
              }
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: GlobalColors.mainColor,
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text(
              'POSTING SEKARANG',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
