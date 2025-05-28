import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/helpers/shared_pref_helper.dart';
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
  final String? imageUrl;
  final String subMessage;
  final bool showImage;

  const HomeTopWidget({
    super.key,
    required this.name,
    this.imageUrl,
    required this.subMessage,
    this.showImage = true,
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
    if (imageUrl != null && imageUrl!.isNotEmpty) _buildProfileImage(),
    if (imageUrl != null && imageUrl!.isNotEmpty)
      SizedBox(width: WidthManager.w20),
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr('hi_with_name', namedArgs: {'name': tr(name)}),
            style: getBoldTextStyle(
              fontSize: FontSizeManager.s18,
              color: ColorsManager.darkBlue,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: HeightManager.h6),
          Text(
            tr(subMessage),
            style: getMediumTextStyle(
              fontSize: FontSizeManager.s13,
              color: ColorsManager.gray,
            ),
          ),
        ],
      ),
    ),
    CircleAvatar(
      radius: RadiusManager.r24,
      backgroundColor: ColorsManager.moreLighterGray,
      child: IconButton(
        icon: Icon(Icons.settings, color: ColorsManager.darkBlue),
        onPressed: () => _showMoreOptionsBottomSheet(context, cubit),
      ),
    ),
    const SignOutBlocListener(),
  ],
),

        SizedBox(height: HeightManager.h8),
      ],
    );
  }

  Widget _buildProfileImage() {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return CircleAvatar(
        radius: RadiusManager.r30,
        backgroundColor: ColorsManager.lightGray,
        child: Icon(Icons.account_circle, size: WidthManager.w40, color: Colors.white),
      );
    }

    return Material(
      elevation: 3,
      shape: const CircleBorder(),
      shadowColor: Colors.black26,
      child: CircleAvatar(
        radius: RadiusManager.r30,
        backgroundColor: Colors.white,
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: imageUrl!,
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
void _showMoreOptionsBottomSheet(BuildContext context, AuthCubit cubit) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    backgroundColor: Colors.white,
    builder: (_) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: WidthManager.w20,
          vertical: HeightManager.h16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(
                Icons.language,
                color: ColorsManager.primaryColor,
              ),
              title: Text(
                context.locale.languageCode == 'en' ? 'العربية' : 'English',
                style: getMediumTextStyle(
                  fontSize: FontSizeManager.s16,
                  color: ColorsManager.darkBlue,
                ),
              ),
              onTap: () {
                final currentLocale = context.locale;
                final newLocale =
                    currentLocale.languageCode == 'en'
                        ? const Locale('ar')
                        : const Locale('en');
                context.setLocale(newLocale);
                SharedPrefHelper.setLocale(newLocale.languageCode);
                Navigator.pop(context); // إغلاق الشيت
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout_rounded, color: Colors.red),
              title: Text(
                'Sign Out'.tr(),
                style: getMediumTextStyle(
                  fontSize: FontSizeManager.s16,
                  color: ColorsManager.darkBlue,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder:
                      (_) => ConfirmationDialog(
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
          ],
        ),
      );
    },
  );
}
