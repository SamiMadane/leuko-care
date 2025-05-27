import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:leuko_care/core/widgets/confirmation_dialog.dart';
import 'package:leuko_care/core/widgets/signout_bloc_listener.dart';
import 'package:leuko_care/feature/auth/logic/cubit/auth_cubit.dart';
import 'package:shimmer/shimmer.dart';
class HomeTopWidget extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String subMessage;
  final bool showSignOut;

  const HomeTopWidget({
    super.key,
    required this.name,
    required this.imageUrl,
    this.subMessage = 'Your health matters most',
    this.showSignOut = true,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildProfileImage(),
            SizedBox(width: WidthManager.w20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('hi_with_name', namedArgs: {'name': name}),
                    style: getBoldTextStyle(
                      fontSize: FontSizeManager.s18,
                      color: ColorsManager.darkBlue,
                    ),
                  ),
                  SizedBox(height: HeightManager.h6),
                  Text(
                    subMessage.tr(),
                    style: getMediumTextStyle(
                      fontSize: FontSizeManager.s13,
                      color: ColorsManager.gray,
                    ),
                  ),
                ],
              ),
            ),
            if (showSignOut)
              IconButton(
                tooltip: 'Sign Out',
                icon: Icon(Icons.logout_rounded, color: ColorsManager.darkBlue),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => ConfirmationDialog(
                      title: 'Confirm Sign Out'.tr(),
                      message: 'Are you sure you want to sign out?'.tr(),
                      confirmText: 'Sign Out'.tr(),
                      onConfirmed: () {
                        cubit.signOut();
                        context.pop();
                      },
                    ),
                  );
                },
              ),
            const SignOutBlocListener(),
          ],
        ),
        SizedBox(height: HeightManager.h8),
        Divider(
          color: ColorsManager.lightGray,
          thickness: 1,
          indent: WidthManager.w76,
          endIndent: WidthManager.w12,
        ),
      ],
    );
  }

  Widget _buildProfileImage() {
    return Material(
      elevation: 3,
      shape: const CircleBorder(),
      shadowColor: Colors.black26,
      child: CircleAvatar(
        radius: RadiusManager.r30,
        backgroundColor: Colors.white,
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            width: WidthManager.w60,
            height: HeightManager.h60,
            fit: BoxFit.cover,
            placeholder: (_, __) => _buildShimmerLoading(),
            errorWidget: (_, __, ___) => Icon(
              Icons.account_circle,
              size: WidthManager.w60,
              color: ColorsManager.gray,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: ColorsManager.lightGray,
      highlightColor: Colors.white,
      child: Container(
        width: WidthManager.w60,
        height: HeightManager.h60,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
      ),
    );
  }
}
