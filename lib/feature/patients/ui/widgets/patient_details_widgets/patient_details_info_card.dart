import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/widgets/patient_status_widgets.dart';
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
            _buildPatientInfoRow(Icons.email, 'Email', patient.email),
            const Divider(),
            _buildPatientInfoRow(Icons.phone, 'Phone', patient.phone),
            const Divider(),
            _buildPatientInfoRow(Icons.calendar_today, 'Age', '$age years'),
            const Divider(),
            _buildPatientInfoRow(
              Icons.check_circle_outline,
              'Examined',
              ExaminedStatusWidget(isExamined: patient.isExamined),
            ),

            const Divider(),
            _buildPatientInfoRow(
              Icons.health_and_safety,
              'Health Status',
              HealthStatusWidget(status: patient.healthStatus),
            ),
            const Divider(),
            _buildPatientInfoRow(
              Icons.date_range,
              'Registration Date',
              _buildRegistrationDate(patient.registrationDate),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientInfoRow(IconData icon, String title, dynamic value) {
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
