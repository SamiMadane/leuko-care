import 'package:cached_network_image/cached_network_image.dart';
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
    this.subMessage = 'Your health matters most.',
    this.showSignOut = true,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();

    return Column(
      children: [
        Row(
          children: [
            _buildProfileImage(),
            SizedBox(width: WidthManager.w12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi, $name',
                    style: getBoldTextStyle(
                      fontSize: FontSizeManager.s20,
                      color: ColorsManager.darkBlue,
                    ),
                  ),
                  SizedBox(height: HeightManager.h4),
                  Text(
                    subMessage,
                    style: getSemiBoldTextStyle(
                      fontSize: FontSizeManager.s13,
                      color: ColorsManager.gray,
                    ),
                  ),
                ],
              ),
            ),
            if (showSignOut)
              CircleAvatar(
                radius: RadiusManager.r22,
                backgroundColor: ColorsManager.moreLighterGray,
                child: IconButton(
                  icon: const Icon(Icons.exit_to_app),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => ConfirmationDialog(
                        title: 'Confirm Sign Out',
                        message: 'Are you sure you want to sign out?',
                        confirmText: 'SignOut',
                        onConfirmed: () {
                          cubit.signOut();
                          context.pop();
                        },
                      ),
                    );
                  },
                ),
              ),
            const SignOutBlocListener(),
          ],
        ),
        SizedBox(height: HeightManager.h6),
        Padding(
          padding: EdgeInsets.only(
            left: WidthManager.w80,
            right: WidthManager.w12,
          ),
          child: Align(
            alignment: Alignment.centerRight,
            child: Divider(color: ColorsManager.lightGray, thickness: 1),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileImage() {
    return Material(
      elevation: 2,
      shape: const CircleBorder(),
      shadowColor: ColorsManager.black87,
      child: CircleAvatar(
        radius: RadiusManager.r30,
        backgroundColor: Colors.transparent,
        backgroundImage: null,
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            width: WidthManager.w60,
            height: HeightManager.h60,
            fit: BoxFit.cover,
            placeholder: (_, __) => _buildShimmerLoading(),
            errorWidget: (_, __, ___) =>
                const Icon(Icons.error, color: Colors.red),
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
        radius: RadiusManager.r34,
        backgroundColor: Colors.white,
      ),
    );
  }
}
