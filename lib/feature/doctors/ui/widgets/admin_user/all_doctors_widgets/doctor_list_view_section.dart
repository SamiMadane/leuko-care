import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/assets_manager.dart';
import 'package:leuko_care/core/widgets/empty_state_widget.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/admin_user/all_doctors_widgets/doctor_list_tile.dart';

class DoctorListViewSection extends StatelessWidget {
  final List<DoctorModel> doctors;

  const DoctorListViewSection({
    super.key,
    required this.doctors,
  });

  @override
  Widget build(BuildContext context) {
    if (doctors.isEmpty) {
      return  EmptyStateWidget(
        lottiePath: AssetsManager.searchLottie,
        isFullScreen: true,
        title: 'No matching doctors.'.tr(),
        message: 'Try adjusting your search or filter options.'.tr(),
      );
    }

    return ListView.builder(
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        final doctor = doctors[index];
        return DoctorListTile(doctor: doctor);
      },
    );
  }
}
