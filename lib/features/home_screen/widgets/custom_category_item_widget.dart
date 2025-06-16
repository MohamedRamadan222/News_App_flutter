import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/styles/app_text_styles.dart';

class CustomCategoryItemWidget extends StatelessWidget {
  final String title;
  final Function() onTap;

  const CustomCategoryItemWidget({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(56.r), // Match border radius
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 6.h),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffE9EFFA), width: 1),
            borderRadius: BorderRadius.circular(56.r),
            color: Colors.transparent,
          ),
          child: Text(title, style: AppTextStyles.black14SemiBold),
        ),
      ),
    );
  }
}
