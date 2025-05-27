import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';

class CommonSearchAndFilterBar extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback onActionPressed;
  final IconData actionIcon;
  final String hintText;

  const CommonSearchAndFilterBar({
    super.key,
    required this.searchController,
    required this.onActionPressed,
    required this.actionIcon,
    this.hintText = 'search_by_name_or_email',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: WidthManager.w16, vertical: HeightManager.h16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: hintText.tr(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: WidthManager.w16,
                  vertical: HeightManager.h12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(RadiusManager.r16),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
          ),
          SizedBox(width: WidthManager.w8),
          Material(
            color: Theme.of(context).primaryColor,
            shape: const CircleBorder(),
            child: IconButton(
              icon: Icon(actionIcon, color: Colors.white),
              onPressed: onActionPressed,
            ),
          ),
        ],
      ),
    );
  }
}
