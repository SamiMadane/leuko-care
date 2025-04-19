import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/feature/admin-home/logic/cubit/admin_home_cubit.dart';
import 'package:shimmer/shimmer.dart';

class DoctorDepartmentListViewItem extends StatelessWidget {
  final dynamic doctor;
  final bool isSelected;
  final int index;

  const DoctorDepartmentListViewItem({
    super.key,
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
                      border: Border.all(color: ColorsManager.darkBlue),
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: RadiusManager.r32,
                      backgroundColor: Colors.grey[200],
                      child: ClipOval(
                        child: SizedBox(
                          width: WidthManager.w64,
                          height: HeightManager.h64,
                          child: CachedNetworkImage(
                            imageUrl: doctor.profileImage,
                            fit: BoxFit.cover,
                            placeholder:
                                (context, url) => _buildShimmerLoading(),
                            errorWidget:
                                (context, url, error) =>
                                    const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                  )
                  : CircleAvatar(
                    radius: RadiusManager.r30,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: null,
                    child: ClipOval(
                      child: SizedBox(
                        width: WidthManager.w60,
                        height: HeightManager.h60,
                        child: CachedNetworkImage(
                          imageUrl: doctor.profileImage,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => _buildShimmerLoading(),
                          errorWidget:
                              (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                    ),
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

  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: ColorsManager.lightGray,
      highlightColor: Colors.white,
      child: CircleAvatar(
        radius: RadiusManager.r28,
        backgroundColor: Colors.white,
      ),
    );
  }
}
