import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:test_app/provider/recipe_provider.dart';
import 'package:test_app/widgets/recipe/recipe_form.dart';
import 'package:test_app/widgets/recipe/recipe_list.dart';

import '../../model/recipe_model.dart';

class RecipeHome extends StatefulWidget {
  const RecipeHome({super.key});

  @override
  State<RecipeHome> createState() => _RecipeHomeState();
}

class _RecipeHomeState extends State<RecipeHome> {
  @override
  Widget build(BuildContext context) {
    final recipe = Provider.of<RecipeProvider>(context);
    void recipeForm(
      String title,
      String description,
      String ingredients,
    ) {
      recipe.addRecipe(Recipe(
          id: "",
          title: title,
          description: description,
          ingredients: ingredients));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('RecipeList')),
      body: RecipeList(),
    );
  }
}

// RecipeForm(
//         recipeBtn: recipeForm,
//       )
