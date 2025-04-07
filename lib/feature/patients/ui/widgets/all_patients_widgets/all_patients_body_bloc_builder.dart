import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/resourses/fonts_manager.dart';
import 'package:leuko_care/core/resourses/sizes_util_manager.dart';
import 'package:leuko_care/core/resourses/styles_manager.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:leuko_care/feature/patients/logic/cubit/patient_cubit.dart';
import 'package:leuko_care/feature/patients/logic/cubit/patient_state.dart';

class AllPatientsBodyBlocBuilder extends StatelessWidget {
  const AllPatientsBodyBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientCubit, PatientState>(
      buildWhen:
          (previous, current) =>
              current is GetPatientStateLoading ||
              current is GetPatientStateSuccess ||
              current is GetPatientStateError,
      builder: (context, state) {
        return state.whenOrNull(
              getPatientStateLoading: () => _buildPatientsLoadingWidget(),
              getPatientStateSuccess:
                  (patients) => _buildPatientsSuccessWidget(patients),
              getPatientStateError:
                  (message) => _buildPatientsErrorWidget(message: message),
            ) ?? 
            const SizedBox.shrink(); // fallback إذا لم تكن أي حالة
      },
    );
  }

  Widget _buildPatientsLoadingWidget() {
    return Center(
      child: CircularProgressIndicator(color: ColorsManager.primaryColor),
    );
  }

  Widget _buildPatientsSuccessWidget(List<PatientModel> patients) {
    if (patients.isEmpty) {
      return const Center(child: Text('No patients available.'));
    }

    return ListView.builder(
      itemCount: patients.length,
      itemBuilder: (context, index) {
        final patient = patients[index];
        return Card(
          margin: EdgeInsets.symmetric(
            vertical: HeightManager.h8,
            horizontal: WidthManager.w16,
          ),
          elevation: 4,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(
              vertical: HeightManager.h18,
              horizontal: WidthManager.w18,
            ),
            title: Text(
              patient.name,
              style: getBoldTextStyle(
                fontSize: FontSizeManager.s18,
                color: ColorsManager.darkBlue,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: HeightManager.h6),
                Text(patient.email),
                SizedBox(height: HeightManager.h4),
                // يمكنك إضافة بيانات إضافية مثل الحالة الصحية هنا
              ],
            ),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(patient.profileImage),
              radius: RadiusManager.r28,
            ),
            onTap: () {
              context.pushNamed(
                Routes.patientDetailsScreen,
                arguments: patient,
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildPatientsErrorWidget({required String message}) {
    return Center(
      child: Text(message, style: const TextStyle(color: Colors.red)),
    );
  }
}