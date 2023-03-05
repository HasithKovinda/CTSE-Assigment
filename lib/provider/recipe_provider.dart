import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:test_app/model/recipe_model.dart';
import 'package:http/http.dart' as http;

class RecipeProvider with ChangeNotifier {
  List<Recipe> _recipes = [];
  List<Recipe> get allRecipes {
    return [..._recipes];
  }

  Future<void> addRecipe(Recipe recipe) async {
    try {
      var url = Uri.https(
        'sample-application-52283-default-rtdb.firebaseio.com',
        '/recipe.json',
      );
      var response = await http.post(url,
          body: json.encode({
            'title': recipe.title,
            'description': recipe.description,
            'ingredients': recipe.ingredients
          }));
      Recipe newRecipe = Recipe(
          title: recipe.title,
          description: recipe.description,
          ingredients: recipe.ingredients,
          id: json.decode(response.body)['name']);
      _recipes.add(newRecipe);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchRecipes() async {
    try {
      var url = Uri.https(
        'sample-application-52283-default-rtdb.firebaseio.com',
        '/recipe.json',
      );
      var response = await http.get(url);
      final data = json.decode(response.body) as Map<String, dynamic>;
      List<Recipe> loadTaskList = [];
      data.forEach((id, recipe) {
        loadTaskList.add(Recipe(
            id: id,
            title: recipe['title'],
            description: recipe['description'],
            ingredients: recipe['ingredients']));
      });
      _recipes = loadTaskList;

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
