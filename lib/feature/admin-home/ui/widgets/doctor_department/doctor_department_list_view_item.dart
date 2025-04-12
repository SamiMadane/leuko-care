import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/resourses/fonts_manager.dart';
import 'package:leuko_care/core/resourses/sizes_util_manager.dart';
import 'package:leuko_care/core/resourses/styles_manager.dart';
import 'package:leuko_care/feature/admin-home/logic/cubit/admin_home_cubit.dart';

class DoctorDepartmentListViewItem extends StatelessWidget {
  final dynamic doctor;
  final bool isSelected;
  final int index;

  const DoctorDepartmentListViewItem({
    required this.doctor,
    required this.isSelected,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<AdminHomeCubit>().selectDoctor(doctor),
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          start: index == 0 ? 0 : WidthManager.w10,
        ),
        child: SizedBox(
          width: 90,
          child: Column(
            children: [
              isSelected
                  ? Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorsManager.primaryColor),
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: RadiusManager.r30,
                      backgroundImage: NetworkImage(doctor.profileImage),
                    ),
                  )
                  : CircleAvatar(
                    radius: RadiusManager.r28,
                    backgroundImage: NetworkImage(doctor.profileImage),
                  ),
              SizedBox(height: HeightManager.h8),
              Text(
                doctor.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    isSelected
                        ? getBoldTextStyle(
                          fontSize: FontSizeManager.s14,
                          color: ColorsManager.darkBlue,
                        )
                        : getRegularTextStyle(
                          fontSize: FontSizeManager.s12,
                          color: ColorsManager.darkBlue,
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
