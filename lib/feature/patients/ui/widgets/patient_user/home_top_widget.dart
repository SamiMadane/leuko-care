import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';

class HomeTopWidget extends StatelessWidget {
  final String name;
  final String imageUrl;
  final VoidCallback onSignOut;

  const HomeTopWidget({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.onSignOut,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 36,
          backgroundImage: NetworkImage(imageUrl),
        ),
        SizedBox(width: WidthManager.w16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Welcome,", style: TextStyle(fontSize: 20)),
              Text(
                name,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.logout, color: Colors.redAccent),
          onPressed: onSignOut,
        ),
      ],
    );
  }
}
