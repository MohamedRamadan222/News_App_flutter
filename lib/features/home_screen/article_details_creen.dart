import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/styles/app_text_styles.dart';
import 'package:news_app/core/widgets/spacing_widgets.dart';
import 'package:news_app/features/home_screen/models/top_headlines_model.dart';

class ArticleDetailsCreen extends StatelessWidget {
  final Article article;
  const ArticleDetailsCreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.red,
        child: Stack(
          children: [
            SizedBox(
              width: 430.w,
              height: 316.h,
              child: CachedNetworkImage(
                imageUrl:
                    article.urlToImage ??
                    "https://static.toiimg.com/photo/msid-109960309/109960309.jpg",
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              top: 200.h,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.8,
                padding: EdgeInsets.only(top: 24.h, left: 24.w, right: 24.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24.r),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.title ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.titleStyles.copyWith(
                          fontSize: 18.sp,
                          color: Colors.black,
                        ),
                      ),
                      const HeightSpace(10),
                      Text(
                        "${article.author ?? "Unknown"} . ${DateFormat('yyyy-MM-dd HH:mm').format(article.publishedAt!)}",
                  
                        style: AppTextStyles.gray14Regular.copyWith(
                          fontSize: 12.sp,
                        ),
                      ),
                      const HeightSpace(34),
                      SizedBox(
                        width: MediaQuery.of(context).size.width *0.9,
                        child: Text(
                            article.description.toString(),
                          style: AppTextStyles.gray14Regular.copyWith(
                            fontSize: 20.sp,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
