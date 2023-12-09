import 'base_network.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();

  Future<Map<String, dynamic>> loadCategories() {
    return BaseNetwork.get("categories.php");
  }

  Future<Map<String, dynamic>> loadMeals() {
    return BaseNetwork.get("filter.php?c=Seafood");
  }

  Future<Map<String, dynamic>> loadDetails() {
    return BaseNetwork.get("lookup.php?i=52772");
  }

}