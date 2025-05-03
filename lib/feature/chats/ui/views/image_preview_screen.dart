import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class ImagePreviewScreen extends StatelessWidget {
  final String imageUrl;

  const ImagePreviewScreen({super.key, required this.imageUrl});

  // منطق حفظ الصورة في المعرض
  Future<void> _saveImage(BuildContext context) async {
    try {
      final result = await ImageGallerySaver.saveFile(imageUrl);
      print( "Image saved to gallery!");
    } catch (e) {
      print( "Failed to save image");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Image Preview',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_alt),
            onPressed: () => _saveImage(context), // حفظ الصورة عند الضغط على زر الحفظ
          ),
        ],
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image, size: 100, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
