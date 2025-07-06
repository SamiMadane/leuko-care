import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:leuko_care/core/helpers/shared_pref_helper.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: WidthManager.w16,
          vertical: HeightManager.h10,
        ),
        child: GestureDetector(
          onTap: () {
            final currentLocale = context.locale;
            final newLocale =
                currentLocale.languageCode == 'en'
                    ? const Locale('ar')
                    : const Locale('en');
            context.setLocale(newLocale);
             SharedPrefHelper.setLocale(newLocale.languageCode);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.language, color: ColorsManager.primaryColor),
              SizedBox(width: WidthManager.w4),
              Text(
                context.locale.languageCode == 'en' ? 'العربية' : 'English',
                style: getSemiBoldTextStyle(
                  fontSize: FontSizeManager.s14,
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
