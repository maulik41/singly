import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:singly/core/theme/app_colors.dart';

class ImageViewerPage extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;

  const ImageViewerPage({
    super.key,
    required this.imageUrls,
    required this.initialIndex,
  });

  @override
  State<ImageViewerPage> createState() => _ImageViewerPageState();
}

class _ImageViewerPageState extends State<ImageViewerPage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    final topOverlayHeight = MediaQuery.of(context).padding.top + 64;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          // Fullscreen image view with only top padding
          PageView.builder(
            controller: _pageController,
            itemCount: widget.imageUrls.length,
            itemBuilder: (context, index) {
              final url = widget.imageUrls[index];
              return Container(
                padding: EdgeInsets.only(top: topOverlayHeight),
                width: double.infinity,
                height: double.infinity,
                child: Hero(
                  tag: url,
                  child: CachedNetworkImage(
                    imageUrl: url,
                    fit: BoxFit.contain,
                    placeholder: (_, __) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (_, __, ___) =>
                        Icon(Icons.broken_image, color: AppColors.white),
                  ),
                ),
              );
            },
          ),

          // Top overlay with close button
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              height: topOverlayHeight,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black87, Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(Icons.close, color: AppColors.white, size: 28),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
