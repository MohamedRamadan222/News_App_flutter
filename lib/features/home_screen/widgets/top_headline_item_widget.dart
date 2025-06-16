import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/styles/app_text_styles.dart';
import 'package:news_app/core/widgets/spacing_widgets.dart';

class TopHeadlineItemWidget extends StatelessWidget {
  final String title;
  final String autherName;
  final String date;
  final String? imageUrl;

  const TopHeadlineItemWidget({
    super.key,
    required this.title,
    required this.autherName,
    required this.date,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: CachedNetworkImage(
              imageUrl:
                  imageUrl ??
                  "https://img.freepik.com/free-vector/people-showcasing-different-types-ways-access-news_53876-43017.jpg?semt=ais_hybrid&w=740",
              height: 206.h,
              fit: BoxFit.fill,
            ),
          ),
        ),
        const HeightSpace(16),
        Text(title,style: AppTextStyles.titleStyles.copyWith(
          fontSize: 18.sp,
          color: Colors.black
          ),
        ),
        const HeightSpace(10),
        Text("$autherName . $date",style: AppTextStyles.gray14Regular.copyWith(),
        ),
      ],
    );
  }
}
