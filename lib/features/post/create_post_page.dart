import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:singly/core/theme/app_colors.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController _textController = TextEditingController();
  final List<File> _selectedImages = [];
  final int _maxImages = 5;

  bool _hasExistingPost = false;

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final picked = await picker.pickMultiImage(imageQuality: 70);

    if (picked.isNotEmpty) {
      final newImages = picked.map((x) => File(x.path)).toList();

      setState(() {
        _selectedImages.addAll(
          newImages.take(_maxImages - _selectedImages.length),
        );
      });
    }
  }

  void _removeImage(int index) {
    setState(() => _selectedImages.removeAt(index));
  }

  void _removeExistingPost() {
    setState(() {
      _hasExistingPost = false;
      _textController.clear();
      _selectedImages.clear();
    });
  }

  void _submitPost() {
    if (_selectedImages.isEmpty && _textController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Can't post empty content.")),
      );
      return;
    }

    // Submit logic here

    setState(() {
      _hasExistingPost = true;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Post uploaded!")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.textPrimary),
          onPressed: _onClosePressed,
        ),
        title: Text(
          _hasExistingPost ? 'Your Post' : 'Create Post',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          if (!_hasExistingPost)
            Padding(
              padding: const EdgeInsets.only(
                right: 12,
              ), // Add spacing from right edge
              child: ElevatedButton(
                onPressed: _submitPost,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary, // Black background
                  foregroundColor: Colors.white, // White text
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Post',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _hasExistingPost
              ? _buildExistingPostView()
              : _buildCreateForm(),
        ),
      ),
    );
  }

  Widget _buildCreateForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _textController,
          maxLines: null,
          decoration: const InputDecoration(
            hintText: 'What’s on your mind?',
            border: InputBorder.none,
          ),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 12),
        if (_selectedImages.isNotEmpty) _buildImageGrid(),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: _selectedImages.length < _maxImages ? _pickImages : null,
          icon: const Icon(Icons.image_outlined),
          label: Text('Add Images (${_selectedImages.length}/$_maxImages)'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageGrid() {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: _selectedImages.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        final image = _selectedImages[index];
        return Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(image, fit: BoxFit.cover),
            ),
            Positioned(
              top: 4,
              right: 4,
              child: GestureDetector(
                onTap: () => _removeImage(index),
                child: const CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.black54,
                  child: Icon(Icons.close, color: Colors.white, size: 16),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildExistingPostView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Your current post:",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.divider),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('This is a sample post content.'),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(
                  2,
                  (index) => Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.image),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextButton.icon(
                onPressed: _confirmRemoveExistingPost,
                icon: const Icon(Icons.delete_outline),
                label: const Text('Remove'),
                style: TextButton.styleFrom(foregroundColor: AppColors.error),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _onClosePressed() {
    final hasUnsavedChanges =
        _textController.text.trim().isNotEmpty || _selectedImages.isNotEmpty;

    if (!hasUnsavedChanges) {
      Navigator.pop(context);
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Discard Post?'),
          content: const Text(
            'You have unsaved changes. Are you sure you want to discard this post?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Close dialog only
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Close page
              },
              child: const Text(
                'Discard',
                style: TextStyle(color: AppColors.error),
              ),
            ),
          ],
        );
      },
    );
  }

  void _confirmRemoveExistingPost() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove?'),
        content: const Text(
          'Are you sure you want to delete your existing post?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              _removeExistingPost(); // Delete post
            },
            child: const Text(
              'Remove',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
