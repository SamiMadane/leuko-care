import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:leuko_care/core/resources/assets_manager.dart';
import 'package:leuko_care/core/resources/colors_manager.dart';
import 'package:leuko_care/core/resources/fonts_manager.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/resources/styles_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // الجزء العلوي - الستارة المنحنية
          Container(
            height: screenHeight * 0.34,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorsManager.lightBlueAccent,
                  ColorsManager.primaryColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(RadiusManager.r40),
                bottomRight: Radius.circular(RadiusManager.r40),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: WidthManager.w16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AssetsManager.appIcon,
                      width: WidthManager.w70,
                      height: HeightManager.h70,
                    ),
                    SizedBox(height: HeightManager.h8),
                    Text(
                      'app_name'.tr(),
                      style: getBoldTextStyle(
                        fontSize: FontSizeManager.s20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: HeightManager.h4),
                    Text(
                      'project_title'.tr(),
                      style: getMediumTextStyle(
                        fontSize: FontSizeManager.s14,
                        color: Colors.white,
                        height: HeightManager.h1_1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: HeightManager.h8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AssetsManager.ptcLogoImage,
                          width: WidthManager.w50,
                          height: HeightManager.h50,
                        ),
                        SizedBox(width: WidthManager.w12),
                        Text(
                          'college_name'.tr(),
                          style: getMediumTextStyle(
                            fontSize: FontSizeManager.s14,
                            color: ColorsManager.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // المحتوى الرئيسي
          Padding(
            padding: EdgeInsets.only(
              top: screenHeight * 0.34 + HeightManager.h10,
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(WidthManager.w20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader('supervised_by'.tr()),
                  _buildSupervisorCard(),
                  SizedBox(height: HeightManager.h20),

                  _buildSectionHeader('team_members_title'.tr()),
                  _buildTeamGrid(context),

                  SizedBox(height: HeightManager.h32),
                ],
              ),
            ),
          ),
          Positioned(
            top: 10,
            child: SafeArea(
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Column(
      children: [
        Text(
          title,
          style: getBoldTextStyle(
            fontSize: FontSizeManager.s16,
            color: ColorsManager.darkBlue,
          ),
        ),
        SizedBox(height: HeightManager.h12),
      ],
    );
  }

  Widget _buildSupervisorCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(RadiusManager.r12),
      ),
      color: ColorsManager.moreLightGray,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: HeightManager.h10,
          horizontal: WidthManager.w16,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: RadiusManager.r30,
              backgroundImage: AssetImage(AssetsManager.drSamiImage),
            ),
            SizedBox(width: WidthManager.w12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dr. Sami Salamah".tr(),
                    style: getBoldTextStyle(
                      fontSize: FontSizeManager.s15,
                      color: ColorsManager.darkBlue,
                    ),
                  ),
                  SizedBox(height: HeightManager.h4),
                  Text(
                    "Project Supervisor".tr(),
                    style: getMediumTextStyle(
                      fontSize: FontSizeManager.s13,
                      color: ColorsManager.gray,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamGrid(BuildContext context) {
    final List<Map<String, dynamic>> teamMembers = [
      {
        'name': 'Sami Al-Madani'.tr(),
        'role': 'team_sami_role'.tr(),
        'image': AssetsManager.samiImage,
        'whatsapp': '972597017012',
        'linkedin': 'https://www.linkedin.com/in/samimadane/',
        'github': 'https://github.com/SamiMadane',
      },
      {
        'name': 'Ahmed Al-Kahlout'.tr(),
        'role': 'team_ahmad_role'.tr(),
        'image': AssetsManager.ahmedImage,
        'whatsapp': '972594560325',
        'linkedin': 'https://www.linkedin.com/in/ahmed-al-kahlout-20/',
        'github': 'https://github.com/ahmedn01kahlout',
      },
      {
        'name': 'Shaimaa Abu Youcef'.tr(),
        'role': 'team_shimaa_role'.tr(),
        'image': AssetsManager.shaimaaImage,
        'whatsapp': '970593470080',
        'linkedin': 'https://www.linkedin.com/in/shaimaa-abu-yousef-a62951234/',
        'github': 'https://github.com/samialmadani',
      },
      {
        'name': 'Manar Attalla'.tr(),
        'role': 'team_manar_role'.tr(),
        'image': AssetsManager.manarImage,
        'whatsapp': '970599179927',
        'linkedin': 'https://www.linkedin.com/in/sami-almadani',
        'github': 'https://github.com/samialmadani',
      },
    ];

    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      childAspectRatio: 0.7,
      children:
          teamMembers.map((member) {
            Widget cardContent = Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(member['image']),
                  ),
                  SizedBox(height: HeightManager.h8),
                  Text(
                    member['name'],
                    textAlign: TextAlign.center,
                    style: getBoldTextStyle(
                      fontSize: FontSizeManager.s14,
                      color: ColorsManager.darkBlue,
                    ),
                  ),
                  SizedBox(height: HeightManager.h4),
                  Text(
                    member['role'],
                    textAlign: TextAlign.center,
                    style: getSemiBoldTextStyle(
                      fontSize: FontSizeManager.s11,
                      color: ColorsManager.gray,
                      height: HeightManager.h1_1,
                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (member['whatsapp'] != null)
                        InkWell(
                          child: Image.asset(
                            AssetsManager.whatsappLogoImage,
                            width: 24,
                            height: 24,
                          ),
                          onTap: () => _launchWhatsapp(member['whatsapp']),
                        ),
                      if (member['linkedin'] != null)
                        InkWell(
                          child: Image.asset(
                            AssetsManager.linkedinLogoImage,
                            width: 24,
                            height: 24,
                          ),
                          onTap: () => _launchUrl(member['linkedin']),
                        ),
                      if (member['github'] != null)
                        InkWell(
                          child: Image.asset(
                            AssetsManager.githubLogoImage,
                            width: 24,
                            height: 24,
                          ),

                          onTap: () => _launchUrl(member['github']),
                        ),
                    ],
                  ),
                ],
              ),
            );
            return Card(
              elevation: 2,
              color: ColorsManager.moreLightGray,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: cardContent,
            );
          }).toList(),
    );
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $url');
    }
  }

  void _launchWhatsapp(String phone) async {
    final whatsappAppUrl = Uri.parse('whatsapp://send?phone=$phone');
    final whatsappWebUrl = Uri.parse('https://wa.me/$phone');

    if (await canLaunchUrl(whatsappAppUrl)) {
      await launchUrl(whatsappAppUrl);
    } else if (await canLaunchUrl(whatsappWebUrl)) {
      await launchUrl(whatsappWebUrl, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch WhatsApp for $phone');
    }
  }
}
