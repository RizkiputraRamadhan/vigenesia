// file: component/EditPost.dart
import 'package:flutter/material.dart';
import 'package:vigenesia/utils/global.color.dart';

class EditPost extends StatelessWidget {
  final Function(String content)? onSubmit;

  const EditPost({super.key, this.onSubmit});

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
                  child: EditPostModal(onSubmit: onSubmit),
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

class EditPostModal extends StatefulWidget {
  final Function(String content)? onSubmit;
  final String? initialContent; // Add a parameter for initial content

  const EditPostModal({super.key, this.onSubmit, this.initialContent});

  @override
  _EsitPostModalState createState() => _EsitPostModalState();
}

class _EsitPostModalState extends State<EditPostModal> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialContent != null) {
      _controller.text = widget.initialContent!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Perbarui Postingan Kamu..',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            maxLines: 5,
            decoration: const InputDecoration(
              hintText: 'Tulis apa yang anda dipikiranmu...',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
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
