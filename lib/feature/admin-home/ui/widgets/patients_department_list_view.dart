import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/resourses/assets_manager.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/resourses/fonts_manager.dart';
import 'package:leuko_care/core/resourses/sizes_util_manager.dart';
import 'package:leuko_care/core/resourses/styles_manager.dart';
import 'package:leuko_care/feature/admin-home/logic/cubit/admin_home_cubit.dart';
import 'package:leuko_care/feature/admin-home/logic/cubit/admin_home_state.dart';

class PatientsDepartmentListView extends StatelessWidget {
  const PatientsDepartmentListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminHomeCubit, AdminHomeState>(
      buildWhen:
          (previous, current) =>
              current is GetPatientsStateLoading ||
              current is GetPatientsStateError ||
              current is GetPatientsStateSuccess,
      builder: (context, state) {
        return state.maybeWhen(
          getPatientsStateLoading: () {
            return const Center(child: CircularProgressIndicator());
          },
          getPatientsStateError: (message) {
            return Center(
              child: Text(
                'Error: $message',
                style: getRegularTextStyle(
                  fontSize: FontSizeManager.s14,
                  color: ColorsManager.darkBlue,
                ),
              ),
            );
          },
          getPatientsStateSuccess: (patients) {
            var filteredPatients =
                context.read<AdminHomeCubit>().filteredPatients;

            // ✅ في حال لا يوجد مرضى
            if (filteredPatients.isEmpty) {
              return Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_off,
                        size: 80,
                        color: ColorsManager.gray,
                      ),
                      SizedBox(height: HeightManager.h16),
                      Text(
                        'No patients found',
                        style: getMediumTextStyle(
                          fontSize: FontSizeManager.s16,
                          color: ColorsManager.gray,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return Expanded(
              child: ListView.builder(
                itemCount: filteredPatients.length,
                itemBuilder: (context, index) {
                  var patient = filteredPatients[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: HeightManager.h16),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            patient.profileImage,
                            width: WidthManager.w110,
                            height: HeightManager.h120,
                            fit: BoxFit.cover,
                          ),
                        ),

                        SizedBox(width: WidthManager.w16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                patient.name,
                                style: getBoldTextStyle(
                                  fontSize: FontSizeManager.s18,
                                  color: ColorsManager.darkBlue,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: HeightManager.h5),

                              // ✅ الهاتف مع أيقونة
                              Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    size: 16,
                                    color: ColorsManager.gray,
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    patient.phone,
                                    style: getMediumTextStyle(
                                      fontSize: FontSizeManager.s12,
                                      color: ColorsManager.gray,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: HeightManager.h5),

                              // ✅ الإيميل مع أيقونة
                              Row(
                                children: [
                                  Icon(
                                    Icons.email,
                                    size: 16,
                                    color: ColorsManager.gray,
                                  ),
                                  SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      patient.email,
                                      style: getMediumTextStyle(
                                        fontSize: FontSizeManager.s12,
                                        color: ColorsManager.gray,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
