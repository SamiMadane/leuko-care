import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';

class DoctorSearchAndFilterBar extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback onToggleSortOrder; // بدل onFilterPressed
  final bool isAscending; // لمعرفة نوع الترتيب الحالي

  const DoctorSearchAndFilterBar({
    super.key,
    required this.searchController,
    required this.onToggleSortOrder,
    required this.isAscending,
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
                prefixIcon: Icon(Icons.search),
                hintText: 'Search by name or email',
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
              icon: Icon(
                isAscending ? Icons.arrow_upward : Icons.arrow_downward,
                color: Colors.white,
              ),
              onPressed: onToggleSortOrder,
            ),
          ),
        ],
      ),
    );
  }
}
