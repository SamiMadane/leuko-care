import 'package:flutter/material.dart';
import 'package:leuko_care/core/resourses/colors_manager.dart';
import 'package:leuko_care/core/resourses/fonts_manager.dart';
import 'package:leuko_care/core/resourses/sizes_util_manager.dart';
import 'package:leuko_care/core/resourses/styles_manager.dart';

class PatientsDepartmentListView extends StatelessWidget {
  const PatientsDepartmentListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: HeightManager.h16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    width: WidthManager.w110,
                    height: HeightManager.h120,
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWjwYSYjlzyrnNwk7mYkNNj2rm04BVlGlQuw&s',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: WidthManager.w16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name',
                        style: getBoldTextStyle(
                          fontSize: FontSizeManager.s18,
                          color: ColorsManager.darkBlue,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: HeightManager.h5),
                      Text(
                        'Degree | Phone',
                        style: getMediumTextStyle(
                          fontSize: FontSizeManager.s12,
                          color: ColorsManager.gray,
                        ),
                      ),
                      SizedBox(height: HeightManager.h5),

                      Text(
                        'Email',
                        style: getMediumTextStyle(
                          fontSize: FontSizeManager.s12,
                          color: ColorsManager.gray,
                        ),
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
  }
}
