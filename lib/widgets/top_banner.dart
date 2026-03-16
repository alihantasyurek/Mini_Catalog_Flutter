import 'package:flutter/material.dart';

class TopBanner extends StatelessWidget {
  const TopBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isPhone = screenWidth < 600;

    return Container(
      margin: EdgeInsets.fromLTRB(isPhone ? 12 : 16, 8, isPhone ? 12 : 16, 6),
      height: isPhone ? 92 : 160,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isPhone ? 16 : 20),
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.network(
        'https://wantapi.com/assets/banner.png',
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          color: Colors.brown.shade50,
          child: const Center(
            child: Icon(Icons.broken_image_outlined, color: Colors.brown),
          ),
        ),
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return Container(
            color: Colors.brown.shade50,
            child: const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
