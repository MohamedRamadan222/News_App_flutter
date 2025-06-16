import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/core/routing/app_routes.dart';
import 'package:news_app/core/styles/app_text_styles.dart';
import 'package:news_app/core/widgets/spacing_widgets.dart';
import 'package:news_app/features/home_screen/models/top_headlines_model.dart';
import 'package:news_app/features/home_screen/services/home_screen_services.dart';
import 'package:news_app/features/home_screen/widgets/articale_card_widget.dart';
import 'package:news_app/features/home_screen/widgets/custom_category_item_widget.dart';
import 'package:news_app/features/home_screen/widgets/search_text_field_widget.dart';
import 'package:news_app/features/home_screen/widgets/top_headline_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffE9EEFA),
        toolbarHeight: 120.h,
        title: Text('explore'.tr(), style: AppTextStyles.titleStyles),
        actions: [
          SearchTextFieldWidget(),
          WidthSpace(10),
          IconButton(
            onPressed: () {
              if (context.locale.languageCode == "en") {
                context.setLocale(Locale("ar"));
              } else {
                context.setLocale(Locale("en"));
              }
              AppConstants.lang = context.locale.languageCode;
            },
            icon: const Icon(Icons.language),
          ),
        ],
      ),
      body: FutureBuilder(
        future: HomeScreenServices().getTopHeadlinesArticle(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (snapshot.hasData) {
            ArticlesModel topHeadLinesModel = snapshot.data! as ArticlesModel;
            if (topHeadLinesModel.totalResults == 0) {
              return Center(child: Text('No articles found'.tr()));
            }

            return Column(
              children: [
                const HeightSpace(16),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 32.w),
                  child: SizedBox(
                    height: 40.h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        CustomCategoryItemWidget(
                          title: "travel".tr(),
                          onTap: () {
                            GoRouter.of(context).pushNamed(
                              AppRoutes.searchResultScreen,
                              extra: 'travel'.tr(),
                            );
                          },
                        ),
                        CustomCategoryItemWidget(
                          title: "technology".tr(),
                          onTap: () {
                            GoRouter.of(context).pushNamed(
                              AppRoutes.searchResultScreen,
                              extra: 'technology'.tr(),
                            );
                          },
                        ),
                        CustomCategoryItemWidget(
                          title: "business".tr(),
                          onTap: () {
                            GoRouter.of(context).pushNamed(
                              AppRoutes.searchResultScreen,
                              extra: 'business'.tr(),
                            );
                          },
                        ),
                        CustomCategoryItemWidget(
                          title: "entertainment".tr(),
                          onTap: () {
                            GoRouter.of(context).pushNamed(
                              AppRoutes.searchResultScreen,
                              extra: 'entertainment'.tr(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const HeightSpace(24),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Column(
                    children: [
                      TopHeadlineItemWidget(
                        imageUrl: topHeadLinesModel.articles![0].urlToImage,
                        date:
                            topHeadLinesModel.articles![0].publishedAt != null
                                ? DateFormat('yyyy-MM-dd HH:mm').format(
                                  topHeadLinesModel.articles![0].publishedAt!,
                                )
                                : 'Unknown',
                        autherName:
                            topHeadLinesModel.articles![0].author ?? 'Unknown',
                        title: topHeadLinesModel.articles![0].title ?? '',
                      ),
                    ],
                  ),
                ),
                const HeightSpace(24),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    child: ListView.builder(
                      itemCount: topHeadLinesModel.articles!.length,
                      itemBuilder: (context, index) {
                        Article article = topHeadLinesModel.articles![index];
                        return ArticleCardWidget(article: article);
                      },
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(child: Text('No data available'));
        },
      ),
    );
  }
}
