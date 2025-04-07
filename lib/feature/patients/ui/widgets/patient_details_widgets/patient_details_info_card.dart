import 'package:flutter/material.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/resourses/fonts_manager.dart';
import 'package:leuko_care/core/resourses/sizes_util_manager.dart';
import 'package:leuko_care/core/resourses/styles_manager.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';

class PatientDetailsInfoCard extends StatelessWidget {
  final PatientModel patient;

  const PatientDetailsInfoCard({
    super.key,
    required this.patient,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(RadiusManager.r16),
      ),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: HeightManager.h16,
          horizontal: WidthManager.w16,
        ),
        child: Column(
          children: [
            _buildRowInfo(Icons.email, 'Email', patient.email),
            const Divider(),
            _buildRowInfo(Icons.phone, 'Phone', patient.phone),
            const Divider(),
            _buildRowInfo(Icons.cake, 'Age', 'patient.age'),
            const Divider(),
            _buildRowInfo(Icons.info_outline, 'Condition', 'patient.condition'),
          ],
        ),
      ),
    );
  }

  Widget _buildRowInfo(IconData icon, String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: HeightManager.h2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: ColorsManager.primaryColor),
          SizedBox(width: WidthManager.w12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: getSemiBoldTextStyle(
                      fontSize: FontSizeManager.s16,
                      color: ColorsManager.darkBlue),
                ),
                SizedBox(height: HeightManager.h6),
                Text(
                  value,
                  style: getRegularTextStyle(
                      fontSize: FontSizeManager.s14,
                      color: ColorsManager.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
