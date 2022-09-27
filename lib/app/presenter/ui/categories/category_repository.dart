import 'package:habits_now_app/app/presenter/ui/categories/category_model.dart';
import 'package:hive/hive.dart';

class CategoryRepository {
  final Box box;
  CategoryRepository(this.box);

  void saveCategory(String name, CategoryModel categoryModel) {
    //var box = Hive.box('catBox');
    if (box.get("names") == null) box.put("names", []);
    List<dynamic> listNames = box.get("names");
    listNames.add(name);
    box.delete("names");
    box.put("names", listNames);
    box.put(name, categoryModel);
  }

  Future<int> clearCat() {
    // var box = Hive.box('catBox');
    var response = box.clear();
    return response;
  }

  List<CategoryModel> getCategories() {
    //var box = Hive.box('catBox');
    List<dynamic> names = box.get("names");
    List<CategoryModel> categories = [];
    for (var name in names) {
      categories.add(box.get(name));
    }
    return categories;
  }

  void deleteCategory(String name) {
    List<dynamic> names = box.get("names");
    names.remove(name);
    box.delete("names");
    box.put("names", names);
    box.delete(name);
    print('$name deleted');
  }
}
