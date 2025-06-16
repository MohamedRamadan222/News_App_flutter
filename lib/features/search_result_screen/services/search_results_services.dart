import 'dart:developer';

import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/core/networking/api_endpoints.dart';
import 'package:news_app/core/networking/dio_helper.dart';
import 'package:news_app/features/home_screen/models/top_headlines_model.dart';

class SearchResultsServices {
  serchItemByName(String query) async {
    try {
      final response = await DioHelper.getRequest(
        endPoints: ApiEndpoints.searchEndpoint,
        query: {
          'apikey': AppConstants.newsApiKey,
          'q': query,
          'language': AppConstants.lang,
        },
      );
      if (response.statusCode == 200) {
        ArticlesModel articlesModel = ArticlesModel.fromJson(response.data);
        log(articlesModel.totalResults.toString());
        return articlesModel;
      }
    } catch (e) {
      log(e.toString());
      return Future.error(e.toString());
    }
  }
}
