import 'dart:developer';

import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/core/networking/api_endpoints.dart';
import 'package:news_app/core/networking/dio_helper.dart';
import 'package:news_app/features/home_screen/models/top_headlines_model.dart';

class HomeScreenServices {
  getTopHeadlinesArticle() async {
    try {
      final response = await DioHelper.getRequest(
        endPoints: ApiEndpoints.topHeadlinesEndpoint,
        query: {'apikey': AppConstants.newsApiKey, 'country': 'us'},
      );
      if (response.statusCode == 200) {
        ArticlesModel topHeadLinesModel = ArticlesModel.fromJson(
          response.data,
        );
        log(topHeadLinesModel.totalResults.toString());
        return topHeadLinesModel;
      }
    } catch (e) {
      log(e.toString());
      return Future.error(e.toString());
    }
  }
}
