import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/core/styles/app_text_styles.dart';
import 'package:news_app/core/widgets/spacing_widgets.dart';
import 'package:news_app/features/home_screen/models/top_headlines_model.dart';
import 'package:news_app/features/home_screen/widgets/articale_card_widget.dart';
import 'package:news_app/features/search_result_screen/services/search_results_services.dart';

class SearchResultScreen extends StatelessWidget {
  final String query;
  const SearchResultScreen({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
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
        title: Text(
          'Search Results'.tr(),
          style: AppTextStyles.black14SemiBold,
        ),
      ),
      body: FutureBuilder(
        future: SearchResultsServices().serchItemByName(query),
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
