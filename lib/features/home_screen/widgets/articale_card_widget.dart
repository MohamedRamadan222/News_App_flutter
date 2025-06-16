import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/routing/app_routes.dart';
import 'package:news_app/core/styles/app_text_styles.dart';
import 'package:news_app/core/widgets/spacing_widgets.dart';
import 'package:news_app/features/home_screen/models/top_headlines_model.dart';

class ArticleCardWidget extends StatelessWidget {
  final Article article;
  const ArticleCardWidget({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(
          context,
        ).pushNamed(AppRoutes.articleDetailsScreen, extra: article);
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 24.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 238.w,
                  child: Text(
                    article.title ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.titleStyles.copyWith(
                      fontSize: 18.sp,
                      color: Colors.black,
                    ),
                  ),
                ),
                const HeightSpace(10),
                SizedBox(
                  width: 238.w,
                  child: Text(
                    "${article.author} . ${DateFormat('yyyy-MM-dd HH:mm').format(article.publishedAt!)}",

                    style: AppTextStyles.gray14Regular.copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 112.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: CachedNetworkImage(
                  imageUrl:
                      article.urlToImage ??
                      "https://img.freepik.com/free-vector/people-showcasing-different-types-ways-access-news_53876-43017.jpg?semt=ais_hybrid&w=740",
                  height: 80.h,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
