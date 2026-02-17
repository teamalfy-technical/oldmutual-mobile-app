import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/affluent/domain/models/content.category.model.dart';

abstract class AffluentDs {
  Future<ApiResponse<List<ContentCategory>>> getContentCategories();
  Future<ApiResponse<ContentCategory>> getContentCategory({required int id});
  Future<ApiResponse<dynamic>> deleteContentCategory({required int id});
}
