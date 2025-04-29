import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/core/widgets/confirmation_dialog.dart';
import 'package:leuko_care/core/widgets/signout_bloc_builder.dart';
import 'package:leuko_care/feature/auth/logic/cubit/auth_cubit.dart';
import 'package:leuko_care/feature/patients/logic/cubit/patient_cubit.dart';
import 'package:leuko_care/feature/patients/logic/cubit/patient_state.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/feature/patients/ui/widgets/patient_user/health_card.dart';
import 'package:leuko_care/feature/patients/ui/widgets/patient_user/home_top_widget.dart';
import 'package:leuko_care/feature/patients/ui/widgets/patient_user/patient_bottom_nav_bar.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({super.key});

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<PatientCubit, PatientState>(
          builder: (context, state) {
            if (state is GetPatientStateLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is GetPatientStateSuccess) {
              final patient = state.patients.first;

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: WidthManager.w20,
                  vertical: HeightManager.h16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeTopWidget(
                      name: patient.name,
                      imageUrl: patient.profileImage,
                      onSignOut: () {
                        showDialog(
                          context: context,
                          builder:
                              (_) => ConfirmationDialog(
                                title: 'Confirm Sign Out',
                                message: 'Are you sure you want to sign out?',
                                onConfirmed: () {
                                  authCubit.signOut();
                                  context.pop();
                                },
                              ),
                        );
                      },
                    ),
                    const SignOutBlocListener(),
                    SizedBox(height: HeightManager.h24),
                    Text(
                      "Your Health Info",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: ColorsManager.darkBlue,
                      ),
                    ),
                    SizedBox(height: HeightManager.h16),
                    if (patient.isExamined) ...[
                      HealthCard(
                        title: "Leukemia Type",
                        value: patient.leukemiaType,
                        icon: Icons.biotech,
                      ),
                      HealthCard(
                        title: "Health Status",
                        value: patient.healthStatus,
                        icon: Icons.health_and_safety,
                      ),
                    ] else ...[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.orange[50],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.hourglass_top,
                              color: Colors.orange,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'You have not been examined yet. Please wait for your doctor to upload your test result.',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    SizedBox(height: HeightManager.h32),
                  ],
                ),
              );
            }

            if (state is GetPatientStateError) {
              return const Center(child: Text('Error loading patient data'));
            }

            return const Center(child: Text('No patient data available'));
          },
        ),
      ),
      bottomNavigationBar: PatientBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });

          switch (index) {
            case 0:
              context.pushReplacementNamed(Routes.patientHomeScreen);
              break;
            case 1:
              // Chat
              break;
            case 2:
              // Profile
              break;
          }
        },
      ),
    );
  }
}
