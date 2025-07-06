import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';

// intiailize this function to be used in the bottom sheet to filter patients by health status and examined status.
// in this way we seprate logic of filtering patients from the UI and we can use it in the future if we need to filter patients by other criteria.
typedef OnFilterSelected = void Function(String filterBy, String filterValue);

class PatientFilterBottomSheet extends StatelessWidget {
  final OnFilterSelected onFilterSelected;

  const PatientFilterBottomSheet({super.key, required this.onFilterSelected});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: WidthManager.w20, vertical: HeightManager.h20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             Text(
              'Filter By'.tr(),
              style:getBoldTextStyle(fontSize: FontSizeManager.s18, color: ColorsManager.darkBlue),
            ),
            SizedBox(height: HeightManager.h8),
            ListTile(
              title:  Text('Examined Status'.tr()),
              leading: const Icon(Icons.check_circle_outline),
              onTap: () async {
                final String? value = await _showFilterValues(
                  context,
                  'Examined Status'.tr(),
                  ['All'.tr(), 'Examined'.tr(), 'Not Examined'.tr()],
                );
                if (value != null) {
                  // store the selected value in the function parameter then in the parent widget we can use it to filter patients based on the selected value.
                  onFilterSelected('Examined Status'.tr(), value);
                  Navigator.pop(context);
                }
              },
            ),
            ListTile(
              title:  Text('Health Status'.tr()),
              leading: const Icon(Icons.health_and_safety_outlined),
              onTap: () async {
                final String? value = await _showFilterValues(
                  context,
                  'Health Status'.tr(),
                  ['All'.tr(), 'Sick'.tr(), 'Healthy'.tr()],
                );
                if (value != null) {
                  onFilterSelected('Health Status'.tr(), value);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> _showFilterValues(
    BuildContext context,
    String filterBy,
    List<String> values,
  ) {
    return showModalBottomSheet<String>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(RadiusManager.r20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: WidthManager.w20, vertical: HeightManager.h16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                tr('select_filter', namedArgs: {'filter': filterBy}),
                style: getBoldTextStyle(fontSize: FontSizeManager.s18, color: ColorsManager.darkBlue),
              ),
               SizedBox(height: HeightManager.h8),
               // ... This dots are used to spread the values list into the ListTile widget expanded area in the bottom sheet.
              ...values.map(
                (val) => ListTile(
                  title: Text(val),
                  leading: const Icon(Icons.tune),
                  onTap: () => Navigator.pop(context, val),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
