import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/resourses/fonts_manager.dart';
import 'package:leuko_care/core/resourses/sizes_util_manager.dart';
import 'package:leuko_care/core/resourses/styles_manager.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_cubit.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_state.dart';

class DoctorsDepartmentListView extends StatelessWidget {
  const DoctorsDepartmentListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorCubit, DoctorState>(
      builder: (context, state) {
        if (state is GetDoctorStateLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is GetDoctorStateError) {
          return Center(
            child: Text(
              'Error: ${state.message}',
              style: getRegularTextStyle(
                fontSize: FontSizeManager.s14,
                color: ColorsManager.darkBlue,
              ),
            ),
          );
        }

        if (state is GetDoctorStateSuccess) {
          return SizedBox(
            height: HeightManager.h100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:
                  state.doctors.length + 1, // زيادة 1 لإضافة زر "Add Doctor"
              itemBuilder: (context, index) {
                if (index == state.doctors.length) {
                  // زر إضافة دكتور جديد
                  return GestureDetector(
                    onTap: () {
                      context.pushNamed(Routes.addUpdateDoctorScreen);
                    },
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: index == 0 ? 0 : WidthManager.w20,
                      ),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: RadiusManager.r30,
                            backgroundColor: ColorsManager.lightBlue,
                            child: Icon(
                              Icons.add,
                              size: 30,
                              color: ColorsManager.primaryColor,
                            ),
                          ),
                          SizedBox(height: HeightManager.h8),
                          Text(
                            'Add Doctor',
                            style: getRegularTextStyle(
                              fontSize: FontSizeManager.s12,
                              color: ColorsManager.darkBlue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                var doctor = state.doctors[index];

                return Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: index == 0 ? 0 : WidthManager.w10,
                  ),
                  child: Container(
                    width: 90,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: RadiusManager.r30,
                          backgroundImage:
                              doctor.profileImage.isNotEmpty
                                  ? NetworkImage(
                                    doctor.profileImage,
                                  ) // صورة الطبيب الفعلية
                                  : null, // لا شيء إذا لم يكن هناك صورة
                          child:
                              doctor.profileImage.isEmpty
                                  ? SvgPicture.asset(
                                    'assets/svgs/general_speciality.svg', // صورة افتراضية
                                    height: HeightManager.h40,
                                    width: WidthManager.w40,
                                  )
                                  : null,
                        ),
                        SizedBox(height: HeightManager.h8),
                        Text(
                          doctor.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getRegularTextStyle(
                            fontSize: FontSizeManager.s12,
                            color: ColorsManager.darkBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
