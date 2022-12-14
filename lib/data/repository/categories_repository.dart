import 'package:injectable/injectable.dart';
import 'package:vn_crypto/data/model/category.dart';
import 'package:vn_crypto/data/service/api_service.dart';

@lazySingleton
class CategoryRepository {
  final Api api;

  CategoryRepository({required this.api});

  Future<List<Category>> getCategories() => api.getCategories();
}
