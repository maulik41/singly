import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:singly/core/theme/app_colors.dart';
import 'package:singly/features/feed/widgets/post_view/post_image_viewer.dart';

class PostImageList extends StatelessWidget {
  final List<String> imageUrls;

  const PostImageList({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: imageUrls.asMap().entries.map((entry) {
        int index = entry.key;
        String url = entry.value;
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    ImageViewerPage(imageUrls: imageUrls, initialIndex: index),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 5),
            width: double.infinity,
            child: Hero(
              tag: url,
              child: CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.contain,
                placeholder: (_, __) => Container(
                  height: 300,
                  color: AppColors.textMuted.withAlpha(20),
                ),
                errorWidget: (_, __, ___) =>
                    const Icon(Icons.broken_image, size: 40),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
