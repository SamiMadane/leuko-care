import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/resourses/fonts_manager.dart';
import 'package:leuko_care/core/resourses/sizes_util_manager.dart';
import 'package:leuko_care/core/resourses/styles_manager.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:leuko_care/feature/patients/logic/cubit/patient_cubit.dart';

class PatientDetailsInfoCard extends StatelessWidget {
  final PatientModel patient;

  const PatientDetailsInfoCard({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    final age = context.read<PatientCubit>().calculateAge(patient.birthDate);

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
            _buildRowInfo(Icons.calendar_today, 'Age', '$age years'),
            const Divider(),
            _buildRowInfo(
              Icons.health_and_safety,
              'Health Status',
              patient.healthStatus == 'unknown'
                  ? 'Health status not determined yet'
                  : patient.healthStatus,
            ),
            const Divider(),
            _buildRowInfo(
              Icons.check_circle_outline,
              'Examined',
              _examinedStatus(patient.isExamined),
            ),
            const Divider(),
            _buildRowInfo(
              Icons.date_range,
              'Registration Date',
              _buildRegistrationDate(patient.registrationDate),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRowInfo(IconData icon, String title, dynamic value) {
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
                    color: ColorsManager.darkBlue,
                  ),
                ),
                SizedBox(height: HeightManager.h6),
                value is Widget
                    ? value
                    : Text(
                      value.toString(),
                      style: getRegularTextStyle(
                        fontSize: FontSizeManager.s14,
                        color: ColorsManager.black87,
                      ),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }

Widget _examinedStatus(bool isExamined) {
  return Row(
    children: [
      Icon(
        isExamined ? Icons.check_circle : Icons.cancel,
        color: isExamined ? Colors.green : Colors.red,
      ),
      SizedBox(width: 8),
      Text(
        isExamined ? 'Patient has been examined' : 'Not examined yet',
        style: TextStyle(
          color: isExamined ? Colors.green[800] : Colors.red[800],
          fontWeight: FontWeight.w600,
          fontSize: FontSizeManager.s14,
        ),
      ),
    ],
  );
}


Widget _buildRegistrationDate(String date) {
  final formattedDate = _formatDate(date);
  return Text(
    formattedDate,
    style: getRegularTextStyle(
      fontSize: FontSizeManager.s14,
      color: ColorsManager.black87,
    ),
  );
}

String _formatDate(String dateString) {
  try {
    final date = DateTime.parse(dateString);
    return DateFormat.yMMMMd().format(date); 
  } catch (e) {
    return dateString; 
  }
}


}
